import 'package:flutter/material.dart';
import 'products_blocbuilder.dart';
import 'text_and_textbutton_inrow.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: TextAndTextButtonInRow(
            text: "Amira's Top Categories",
            onPressed: () {},
            textButton: "View All",
          ),
        ),

        // Category Section
        // CategorySection(),
        // Products Section
        ProductsBlocBuilder(),
        SliverPadding(padding: EdgeInsetsGeometry.only(bottom: 28)),
      ],
    );
  }
}
