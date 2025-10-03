import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'constants/app_routes.dart';
import 'constants/shared_pref_keys.dart';
import 'services/shared_preferences_service.dart';
import 'utils/logging/logger_helper.dart';

String? redirectScreen(BuildContext context, GoRouterState state) {
  final prefs = SharedPreferencesService();

  final seenOnboarding = prefs.getBool(SharedPrefKeys.onboardingSeen);
  final user = FirebaseAuth.instance.currentUser;

  LoggerHelper.debug("Redirect check");
  LoggerHelper.debug("Current location: ${state.fullPath}");
  LoggerHelper.debug("Onboarding seen: $seenOnboarding");
  LoggerHelper.debug("User: ${user?.email ?? "NO USER"}");

  // 1. Onboarding FIRST: if not seen, ignore all other checks
  if (!seenOnboarding) {
    if (state.fullPath != ConstantRoutes.onBoardingViewRoute) {
      LoggerHelper.debug("➡️ Redirecting to OnBoarding");
      return ConstantRoutes.onBoardingViewRoute;
    }
    return null; // ✅ stay on onboarding
  }

  // 2. Then check user login
  if (user == null) {
    final allowedAnonRoutes = {
      ConstantRoutes.logInViewRoute,
      ConstantRoutes.signUpViewRoute,
      ConstantRoutes.forgetPasswordViewRoute,
    };
    if (!allowedAnonRoutes.contains(state.fullPath)) {
      LoggerHelper.debug("Redirecting to Login");
      return ConstantRoutes.logInViewRoute;
    }
    LoggerHelper.debug("Stay at ${state.fullPath}");
    return null;
  }

  // 3. If user exists, check verification
  final isVerified = user.emailVerified;
  if (!isVerified) {
    if (state.fullPath != ConstantRoutes.mailVerificationViewRoute) {
      LoggerHelper.debug("Redirecting to Mail Verification");
      return ConstantRoutes.mailVerificationViewRoute;
    }
    return null;
  }
  // 4. If verified → profile || home
  if (isVerified) {
    final allowedAnonRoutes = {
      ConstantRoutes.profileView,
      ConstantRoutes.successView,
      ConstantRoutes.verifyYourAccountViewRoute,
    };
    if (!allowedAnonRoutes.contains(state.fullPath)) {
      LoggerHelper.debug("Redirecting to Profile");
      return ConstantRoutes.profileView;
    }
    return null;
  }

  LoggerHelper.debug(" Stay at ${state.fullPath}");
  return null;
}
