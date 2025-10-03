import 'package:go_router/go_router.dart';
import 'routes_imports.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    redirect: (context, state) => redirectScreen(context, state),
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
        name: ConstantRoutes.verifyYourAccountViewRoute,
        path: ConstantRoutes.verifyYourAccountViewRoute,
        builder: (context, state) => PhoneVerificationView(),
      ),
      GoRoute(
        path: ConstantRoutes.forgetPasswordViewRoute,
        builder: (context, state) => ForgetPasswordView(),
      ),
      GoRoute(
        name: ConstantRoutes.homeViewRoute,
        path: ConstantRoutes.homeViewRoute,
        builder: (context, state) => HomeView(),
      ),
      GoRoute(
        name: ConstantRoutes.mailVerificationViewRoute,
        path: ConstantRoutes.mailVerificationViewRoute,
        builder: (context, state) => EmailVerificationView(),
      ),
      GoRoute(
        name: ConstantRoutes.successView,
        path: ConstantRoutes.successView,
        builder: (context, state) {
          return SuccessView();
        },
      ),
      GoRoute(
        path: ConstantRoutes.profileView,
        name: ConstantRoutes.profileView,
        builder: (context, state) => UserProfileView(),
      ),
    ],
  );
}
