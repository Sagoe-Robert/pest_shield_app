import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class PestResult {
  PestResult({
    required this.topLabel,
    this.confidence = 0,
    this.topK = const [],
    this.isError = false,
    this.analysis,
    this.suggestions,
  });

  final String topLabel;
  final double confidence;
  final List<({String label, double score})> topK;
  final bool isError;
  final String? analysis;
  final String? suggestions;
}

/// Calls `POST /analyze-pest` on the Pest Shield API.
///
/// Override the server with `--dart-define=API_BASE_URL=https://your-host.com`
/// (no trailing slash). If unset, uses `https://api-pest.onrender.com`.
class PestClassifier {
  static const String _envBase = String.fromEnvironment('API_BASE_URL');
  static const String _defaultBase = 'https://api-pest.onrender.com';

  static String get _baseUrl {
    final e = _envBase.trim();
    final url = e.isNotEmpty ? e : _defaultBase;
    return url.replaceAll(RegExp(r'/$'), '');
  }

  /// FastAPI checks `UploadFile.content_type` starts with `image/`. The `http`
  /// package defaults multipart parts to `application/octet-stream`, which
  /// triggers "Expected an image file." unless we set a real image type.
  static ({MediaType type, String filename}) _imagePartMeta(Uint8List bytes) {
    if (bytes.length >= 3 && bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) {
      return (type: MediaType('image', 'jpeg'), filename: 'capture.jpg');
    }
    if (bytes.length >= 8 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      return (type: MediaType('image', 'png'), filename: 'capture.png');
    }
    if (bytes.length >= 12 &&
        bytes[0] == 0x52 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x46 &&
        bytes[8] == 0x57 &&
        bytes[9] == 0x45 &&
        bytes[10] == 0x42 &&
        bytes[11] == 0x50) {
      return (type: MediaType('image', 'webp'), filename: 'capture.webp');
    }
    return (type: MediaType('image', 'jpeg'), filename: 'capture.jpg');
  }

  Future<PestResult> classify(Uint8List imageBytes) async {
    try {
      final uri = Uri.parse('$_baseUrl/analyze-pest');
      final meta = _imagePartMeta(imageBytes);
      final req = http.MultipartRequest('POST', uri)
        ..files.add(
          http.MultipartFile.fromBytes(
            'file',
            imageBytes,
            filename: meta.filename,
            contentType: meta.type,
          ),
        );
      final streamed = await req.send().timeout(const Duration(seconds: 60));
      final body = await streamed.stream.bytesToString();
      if (streamed.statusCode < 200 || streamed.statusCode >= 300) {
        return PestResult(
          topLabel: 'Server error',
          isError: true,
          analysis: 'HTTP ${streamed.statusCode}${body.isNotEmpty ? ': $body' : ''}',
        );
      }
      final map = jsonDecode(body) as Map<String, dynamic>;
      final pest = (map['pest'] ?? 'Uncertain').toString();
      final analysis = (map['analysis'] ?? '').toString();
      final suggestions = (map['suggestions'] ?? '').toString();
      return PestResult(
        topLabel: pest,
        analysis: analysis.isEmpty ? null : analysis,
        suggestions: suggestions.isEmpty ? null : suggestions,
      );
    } on Object catch (e) {
      return PestResult(
        topLabel: 'Could not reach API',
        isError: true,
        analysis: e.toString(),
        suggestions: 'Check your internet connection and try again.',
      );
    }
  }

  void dispose() {}
}
