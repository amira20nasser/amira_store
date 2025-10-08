import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';
import '../constants/app_routes.dart';

class FakeSearchBar extends StatelessWidget {
  const FakeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(ConstantRoutes.search);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.blackColor.withAlpha(130)),
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.greyColor
              : AppColors.primaryMaterialColor.shade100,
        ),
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: AppColors.blackColor.withAlpha(130),
            ),
            SizedBox(width: 10),
            Text("Search product...."),
          ],
        ),
      ),
    );
  }
}
