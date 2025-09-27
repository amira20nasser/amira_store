import 'package:flutter/material.dart';
import 'core/services/shared_preferences_service.dart';

import 'core/utils/app_router.dart';
import 'core/utils/theme/app_theme.dart';

Future<void> main() async {
  //DONE: add Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();
  //Done: Init local Storage
  await SharedPreferencesService.init();

  //DONE: Initialize firebase

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
