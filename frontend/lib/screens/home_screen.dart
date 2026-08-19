import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/pest_classifier.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _picker = ImagePicker();
  final _classifier = PestClassifier();
  Uint8List? _imageBytes;
  PestResult? _result;
  bool _busy = false;

  @override
  void dispose() {
    _classifier.dispose();
    super.dispose();
  }

  Future<void> _pick(ImageSource source) async {
    final x = await _picker.pickImage(source: source, maxWidth: 1600, imageQuality: 88);
    if (x == null) return;
    final bytes = await x.readAsBytes();
    setState(() {
      _imageBytes = bytes;
      _result = null;
    });
    await _run();
  }

  Future<void> _run() async {
    final imageBytes = _imageBytes;
    if (imageBytes == null) return;
    setState(() => _busy = true);
    try {
      final r = await _classifier.classify(imageBytes);
      if (mounted) setState(() => _result = r);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
        children: [
          Row(
            children: [
              Text('Pest Shield', style: t.textTheme.headlineSmall?.copyWith(color: AppColors.teal)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_horiz_rounded),
                onPressed: () => showModalBottomSheet<void>(
                  context: context,
                  showDragHandle: true,
                  builder: (c) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text('Group 26B — results come from the Pest Shield API. Not extension advice.', style: t.textTheme.bodyMedium),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _busy ? null : () => _pick(ImageSource.camera),
              icon: const Icon(Icons.photo_camera_rounded),
              label: const Text('Click a picture'),
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: _busy ? null : () => _pick(ImageSource.gallery),
            icon: const Icon(Icons.photo_library_outlined),
            label: const Text('Choose from gallery'),
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 4 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _imageBytes == null
                  ? ColoredBox(
                      color: Colors.white,
                      child: Center(child: Icon(Icons.image_outlined, size: 48, color: AppColors.navy.withValues(alpha: 0.35))),
                    )
                  : Image.memory(_imageBytes!, fit: BoxFit.cover),
            ),
          ),
          if (_busy) const Padding(padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator(color: AppColors.teal))),
          if (_result != null) _buildResult(Theme.of(context), _result!),
        ],
      ),
    );
  }

  Widget _buildResult(ThemeData theme, PestResult r) {
    final tx = theme.textTheme;
    if (r.isError) {
      return Card(
        margin: const EdgeInsets.only(top: 20),
        color: Colors.red.shade50,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(r.topLabel, style: tx.titleMedium?.copyWith(color: Colors.red.shade900)),
              if ((r.analysis ?? '').isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(r.analysis!, style: tx.bodySmall),
              ],
              if ((r.suggestions ?? '').isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(r.suggestions!, style: tx.bodySmall),
              ],
            ],
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              r.topLabel.isEmpty ? '-' : '${r.topLabel[0].toUpperCase()}${r.topLabel.substring(1)}',
              style: tx.headlineSmall?.copyWith(color: AppColors.navy),
            ),
            if (r.topK.isNotEmpty && r.confidence > 0) ...[
              const SizedBox(height: 12),
              LinearProgressIndicator(value: r.confidence.clamp(0.0, 1.0), color: AppColors.teal, backgroundColor: AppColors.pageBg),
              const SizedBox(height: 8),
              Text('${(r.confidence * 100).toStringAsFixed(1)}%', style: tx.labelLarge),
              const SizedBox(height: 12),
              for (final e in r.topK)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(children: [Expanded(child: Text(e.label)), Text('${(e.score * 100).toStringAsFixed(1)}%')]),
                ),
            ],
            if ((r.analysis ?? '').isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Analysis', style: tx.titleSmall),
              const SizedBox(height: 4),
              Text(r.analysis!, style: tx.bodySmall),
            ],
            if ((r.suggestions ?? '').isNotEmpty) ...[
              const SizedBox(height: 10),
              Text('Suggestions', style: tx.titleSmall),
              const SizedBox(height: 4),
              Text(r.suggestions!, style: tx.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}
