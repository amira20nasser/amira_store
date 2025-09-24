import 'package:go_router/go_router.dart';

import '../../features/on_boarding/domain/entities/on_boarding_entity.dart';
import '../../features/on_boarding/presentation/views/on_boarding_view.dart';
import '../constants/app_routes.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: ConstantRoutes.onBordingViewRoute,
    routes: [
      GoRoute(
        path: ConstantRoutes.onBordingViewRoute,
        builder: (context, state) =>
            OnBordingView(onBoardingItems: OnBoardingEntity.getItems),
      ),
    ],
    errorBuilder: (context, state) =>
        OnBordingView(onBoardingItems: OnBoardingEntity.getItems),
  );
}
