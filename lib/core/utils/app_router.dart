import 'package:amira_store/features/auth/presentation/views/log_in_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/on_boarding/domain/entities/on_boarding_entity.dart';
import '../../features/on_boarding/presentation/views/on_boarding_view.dart';
import '../constants/app_routes.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: ConstantRoutes.onBordingViewRoute,
    routes: [
      GoRoute(
        name: ConstantRoutes.onBordingViewRoute,

        path: ConstantRoutes.onBordingViewRoute,
        builder: (context, state) =>
            OnBordingView(onBoardingItems: OnBoardingEntity.getItems),
      ),
      GoRoute(
        name: ConstantRoutes.logInViewRoute,
        path: ConstantRoutes.logInViewRoute,
        builder: (context, state) => LogInView(),
      ),

      // GoRoute(
      //   path: ConstantRoutes.authViewRoute,
      //   builder: (context, state) => AuthView(),
      //   routes: [
      //     GoRoute(
      //       path: ConstantRoutes.logInViewRoute,
      //       builder: (context, state) => LogInView(),
      //     ),
      //     GoRoute(
      //       path: ConstantRoutes.signUpViewRoute,
      //       builder: (context, state) => SignUpView(),
      //     ),
      //   ],
      // ),
    ],
    // errorBuilder: (context, state) =>
    //     OnBordingView(onBoardingItems: OnBoardingEntity.getItems),
  );
}
