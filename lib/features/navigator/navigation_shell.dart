import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'bottom_nav_bar.dart';
import 'main_multiblocprovider.dart';
import 'main_view.dart';

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
    return Scaffold(
      // body: navigationShell,
      body: MainViewMultiBloc(
        child: MainView(navigationShell: navigationShell),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onItemTapped,
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: activeColor,
      //   onPressed: () => _onItemTapped(2),
      //   child: Icon(
      //     2 == navigationShell.currentIndex
      //         ? Icons.shopping_cart
      //         : Icons.shopping_cart_outlined,
      //   ),
      // ),
      // floatingActionButton: GestureDetector(
      //   onTap: () => _onItemTapped(2),
      //   child: Container(
      //     height: 65,
      //     width: 65,
      //     decoration: BoxDecoration(shape: BoxShape.circle, color: activeColor),
      //     child: Icon(
      //       navigationShell.currentIndex == 2
      //           ? Icons.shopping_cart
      //           : Icons.shopping_cart_outlined,
      //       color: Colors.white,
      //       size: 30,
      //     ),
      //   ),
      // ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
