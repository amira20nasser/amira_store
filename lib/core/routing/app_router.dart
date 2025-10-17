import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/all_products/all_products_view.dart';
import '../../features/checkout/checkout_view.dart';
import '../../features/home/domain/entities/product_entity.dart';
import 'routes_imports.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: ConstantRoutes.onboarding,
    routes: [
      GoRoute(
        path: ConstantRoutes.onboarding,
        builder: (context, state) =>
            OnBordingView(onBoardingItems: OnBoardingEntity.getItems),
        redirect: (context, state) =>
            Redirection.handleOnboardingRedirect(state),
      ),

      GoRoute(
        path: ConstantRoutes.login,
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
        path: ConstantRoutes.signup,
        builder: (context, state) => SignUpView(),
      ),
      GoRoute(
        path: ConstantRoutes.forgotPassword,
        builder: (context, state) => ForgotPasswordView(),
      ),
      GoRoute(
        path: ConstantRoutes.verifyAccount,
        builder: (context, state) => PhoneVerificationView(),
      ),
      GoRoute(
        path: ConstantRoutes.emailVerification,
        builder: (context, state) => EmailVerificationView(),
      ),
      GoRoute(
        path: ConstantRoutes.success,
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
      GoRoute(
        path: ConstantRoutes.checkOut,
        builder: (context, state) => CheckoutView(),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            NavigationShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ConstantRoutes.home,
                builder: (context, state) => const HomeView(),
                routes: [
                  GoRoute(
                    path: ConstantRoutes.productDetails,
                    builder: (context, state) {
                      final product = state.extra as ProductEntity;
                      return ProductDetailsView(product: product);
                    },
                  ),
                  GoRoute(
                    path: ConstantRoutes.search,
                    builder: (context, state) => SearchView(),
                  ),
                ],
              ),
              GoRoute(
                path: ConstantRoutes.categoryList,
                builder: (context, state) => const CategoriesView(),
                routes: [
                  GoRoute(
                    path: ConstantRoutes.productsByCategory,
                    builder: (context, state) {
                      final categorySlug = state.extra as String;
                      return ProductsByCategoryView(categorySlug: categorySlug);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ConstantRoutes.allProducts,
                builder: (context, state) => const AllProductsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ConstantRoutes.cart,
                builder: (context, state) => const CartView(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ConstantRoutes.profile,
                builder: (context, state) => const UserProfileView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
