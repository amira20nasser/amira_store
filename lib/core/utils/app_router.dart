import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes_imports.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: ConstantRoutes.onBoardingViewRoute,
    routes: [
      GoRoute(
        name: ConstantRoutes.onBoardingViewRoute,
        path: ConstantRoutes.onBoardingViewRoute,
        builder: (context, state) =>
            OnBordingView(onBoardingItems: OnBoardingEntity.getItems),
        redirect: (context, state) =>
            Redirection.handleOnboardingRedirect(state),
      ),
      GoRoute(
        name: ConstantRoutes.logInViewRoute,
        path: ConstantRoutes.logInViewRoute,
        builder: (context, state) => LogInView(),
        redirect: (context, state) => Redirection.handleAuthRedirect(state),
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LogInView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: ConstantRoutes.signUpViewRoute,
        builder: (context, state) => SignUpView(),
      ),
      GoRoute(
        path: ConstantRoutes.forgetPasswordViewRoute,
        builder: (context, state) => ForgotPasswordView(),
      ),
      GoRoute(
        name: ConstantRoutes.verifyYourAccountViewRoute,
        path: ConstantRoutes.verifyYourAccountViewRoute,
        builder: (context, state) => PhoneVerificationView(),
      ),
      GoRoute(
        name: ConstantRoutes.mailVerificationViewRoute,
        path: ConstantRoutes.mailVerificationViewRoute,
        builder: (context, state) => EmailVerificationView(),
      ),
      GoRoute(
        name: ConstantRoutes.profileView,
        path: ConstantRoutes.profileView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const UserProfileView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        name: ConstantRoutes.homeViewRoute,
        path: ConstantRoutes.homeViewRoute,
        builder: (context, state) => HomeView(),
      ),
      GoRoute(
        name: ConstantRoutes.successView,
        path: ConstantRoutes.successView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SuccessEmailView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
        ),
      ),
    ],
  );
}
