import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../search/search_widget.dart';

class ProductsAppBarBody extends StatelessWidget {
  const ProductsAppBarBody({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: Icon(FontAwesomeIcons.angleLeft),
            ),
            Text(categoryName, style: Theme.of(context).textTheme.titleMedium),
            IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.filter)),
          ],
        ),
        SizedBox(height: 10),
        Expanded(child: SearchWidget()),
      ],
    );
  }
}
