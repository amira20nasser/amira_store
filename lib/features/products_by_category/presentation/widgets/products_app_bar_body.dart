import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ProductsByCategoryAppBarBody extends StatelessWidget {
  const ProductsByCategoryAppBarBody({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(FontAwesomeIcons.angleLeft),
        ),
        Text(categoryName, style: Theme.of(context).textTheme.titleMedium),
        // IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.filter)),
        SizedBox(width: 10),
      ],
    );
  }
}
