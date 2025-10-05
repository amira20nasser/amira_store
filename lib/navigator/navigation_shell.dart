import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';

class NavigationShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavigationShell({super.key, required this.navigationShell});

  void _onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color activeColor = AppColors.primaryColor;
    final Color inactiveColor = Theme.of(context).brightness == Brightness.dark
        ? AppColors.whiteColor60
        : AppColors.primaryMaterialColor.shade500;
    double dragDistance = 0;

    return Scaffold(
      body: GestureDetector(
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
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: activeColor,
          unselectedItemColor: inactiveColor,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house),
              activeIcon: Icon(FontAwesomeIcons.solidHouse),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              activeIcon: Icon(Icons.grid_view_rounded),
              label: 'Categories',
            ),
            BottomNavigationBarItem(icon: SizedBox(height: 20), label: 'Cart'),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.heart),
              activeIcon: Icon(FontAwesomeIcons.solidHeart),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.user),
              activeIcon: Icon(FontAwesomeIcons.solidUser),
              label: 'Profile',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: activeColor,
        onPressed: () => _onItemTapped(2),
        child: Icon(
          2 == navigationShell.currentIndex
              ? Icons.shopping_cart
              : Icons.shopping_cart_outlined,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
