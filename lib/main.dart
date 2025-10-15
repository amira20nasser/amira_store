import 'package:amira_store/features/cart/domain/entities/cart_item_entity.dart';
import 'package:amira_store/firebase_options.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/bloc_observer.dart';
import 'core/di/di_imports.dart';
import 'core/network/network_cubit.dart';
import 'core/services/shared_preferences_service.dart';
import 'core/routing/app_router.dart';
import 'core/utils/theme/app_theme.dart';

Future<void> main() async {
  //DONE: add Widgets Binding
  WidgetsFlutterBinding.ensureInitialized();
  // DI
  ServiceLocator.init();
  //
  Bloc.observer = SimpleBlocObserver();
  //Done: Init local Storage
  await SharedPreferencesService.init();
  //DONE: Initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Hive
  await Hive.initFlutter();
  // register adapters
  Hive.registerAdapter(CartItemEntityAdapter());

  // open a box (like a collection)
  await Hive.openBox<CartItemEntity>('cartBox');

  // conectivity
  final connectivity = Connectivity();
  runApp(
    BlocProvider(
      create: (context) => NetworkCubit(connectivity),
      child: const AmiraStore(),
    ),
  );
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
