import 'package:flutter/material.dart';
import '../../../../core/widgets/fake_search_bar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/images/app_logo_bg.png", height: 80),
        Expanded(child: FakeSearchBar()),
      ],
    );
  }
}
