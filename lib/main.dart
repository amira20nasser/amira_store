import 'package:flutter/material.dart';

import 'core/utils/theme/app_theme.dart';

void main() {
  runApp(const AmiraStore());
}

class AmiraStore extends StatelessWidget {
  const AmiraStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
    );
  }
}
