import 'package:go_router/go_router.dart';
import 'constants/app_routes.dart';
import 'constants/shared_pref_keys.dart';
import 'di/service_locator.dart';
import 'services/firebase_service.dart';
import 'services/shared_preferences_service.dart';
import 'utils/logging/logger_helper.dart';

abstract class Redirection {
  static final _authService = ServiceLocator.get<FirebaseAuthService>();
  static final _prefs = SharedPreferencesService();

  static String? handleOnboardingRedirect(GoRouterState state) {
    final seenOnboarding = _prefs.getBool(SharedPrefKeys.onboardingSeen);
    final location = state.fullPath ?? '';
    LoggerHelper.debug("Redirect check --> OnBoarding seen: $seenOnboarding");
    // If seen and currently on onboarding
    if (seenOnboarding && location == ConstantRoutes.onBoardingViewRoute) {
      LoggerHelper.debug("Onboarding done → Go to login");
      return ConstantRoutes.logInViewRoute;
    }
    // No redirect needed
    return null;
  }

  static String? handleAuthRedirect(GoRouterState state) {
    final user = _authService.currentUser;
    final location = state.fullPath ?? '';
    LoggerHelper.debug("User: ${user?.email ?? "NO USER"} | at $location");
    final allowedAnonRoutes = {
      ConstantRoutes.logInViewRoute,
      ConstantRoutes.signUpViewRoute,
      ConstantRoutes.forgetPasswordViewRoute,
    };
    if (user == null) {
      if (!allowedAnonRoutes.contains(location)) {
        return ConstantRoutes.logInViewRoute;
      }
      return null;
    }
    if (!user.emailVerified) {
      if (location != ConstantRoutes.mailVerificationViewRoute &&
          location != ConstantRoutes.profileView) {
        return ConstantRoutes.mailVerificationViewRoute;
      }
      return null;
    }

    final allowedVerifiedRoutes = {
      ConstantRoutes.profileView,
      ConstantRoutes.successView,
      ConstantRoutes.verifyYourAccountViewRoute,
      ConstantRoutes.homeViewRoute,
    };

    if (!allowedVerifiedRoutes.contains(location)) {
      return ConstantRoutes.profileView;
    }

    return null;
  }
}
