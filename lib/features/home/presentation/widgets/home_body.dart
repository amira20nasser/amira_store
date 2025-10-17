import 'package:amira_store/features/home/presentation/widgets/text_and_textbutton_inrow.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_routes.dart';
import 'auto_scroll_category_section.dart';
import 'products_blocbuilder.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: TextAndTextButtonInRow(
            text: 'Everything in One Place',
            textButton: 'VIEW ALL',
            onPressed: () {
              context.push(ConstantRoutes.categoryList);
            },
          ),
        ),

        // Category Section
        // CategorySection(),
        AutoScrollCategorySection(),
        // Products Section
        ProductsBlocBuilder(),
        SliverPadding(padding: EdgeInsetsGeometry.only(bottom: 28)),
      ],
    );
  }
}
