import 'package:flutter/material.dart';

import 'core/utils/app_router.dart';
import 'core/utils/theme/app_theme.dart';

void main() {
  runApp(const AmiraStore());
}

class AmiraStore extends StatelessWidget {
  const AmiraStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      routerConfig: AppRouter.router,
    );
  }
}
