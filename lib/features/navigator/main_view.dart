import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatelessWidget {
  const MainView({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    double dragDistance = 0;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        dragDistance += details.delta.dx;
      },
      onHorizontalDragEnd: (details) {
        final currentIndex = navigationShell.currentIndex;
        final totalBranches = navigationShell.route.branches.length;

        if (dragDistance < -50 && currentIndex < totalBranches - 1) {
          navigationShell.goBranch(currentIndex + 1);
        } else if (dragDistance > 50 && currentIndex > 0) {
          navigationShell.goBranch(currentIndex - 1);
        }

        dragDistance = 0; // reset
      },
      child: navigationShell,
    );
  }
}
