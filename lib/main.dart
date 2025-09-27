import 'package:amira_store/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/services/shared_preferences_service.dart';

import 'core/utils/app_router.dart';
import 'core/utils/logging/logger_helper.dart';
import 'core/utils/theme/app_theme.dart';

Future<void> main() async {
  //DONE: add Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();
  //Done: Init local Storage
  await SharedPreferencesService.init();

  //DONE: Initialize firebase
  var x = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LoggerHelper.debug(x.toString());
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
