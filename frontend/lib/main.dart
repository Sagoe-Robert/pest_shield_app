import 'package:flutter/material.dart';

import 'screens/shell_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PestShieldApp());
}

class PestShieldApp extends StatelessWidget {
  const PestShieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pest Shield Ghana',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const ShellScreen(),
    );
  }
}
