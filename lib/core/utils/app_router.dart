import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/log_in_view.dart';
import '../../features/auth/presentation/views/sign_up_view.dart';
import '../../features/home/home_view.dart';
import '../../features/on_boarding/domain/entities/on_boarding_entity.dart';
import '../../features/on_boarding/presentation/views/on_boarding_view.dart';
import '../constants/app_routes.dart';
import '../constants/shared_pref_keys.dart';
import '../services/shared_preferences_service.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: ConstantRoutes.onBoardingViewRoute,
    routes: [
      GoRoute(
        name: ConstantRoutes.onBoardingViewRoute,

        path: ConstantRoutes.onBoardingViewRoute,
        builder: (context, state) =>
            OnBordingView(onBoardingItems: OnBoardingEntity.getItems),
      ),
      GoRoute(
        name: ConstantRoutes.logInViewRoute,
        path: ConstantRoutes.logInViewRoute,
        builder: (context, state) => LogInView(),
      ),
      GoRoute(
        path: ConstantRoutes.signUpViewRoute,
        builder: (context, state) => SignUpView(),
      ),
      GoRoute(
        path: ConstantRoutes.homeViewRoute,
        builder: (context, state) => HomeView(),
      ),
    ],
    redirect: (context, state) {
      final prefs = SharedPreferencesService();
      final seenOnboarding = prefs.getBool(SharedPrefKeys.onboardingSeen);
      if (!seenOnboarding &&
          !state.fullPath!.contains(ConstantRoutes.onBoardingViewRoute)) {
        return ConstantRoutes.onBoardingViewRoute;
      } else if (seenOnboarding &&
          state.fullPath!.contains(ConstantRoutes.onBoardingViewRoute)) {
        return ConstantRoutes.logInViewRoute;
      }

      return null;
    },
  );
}
