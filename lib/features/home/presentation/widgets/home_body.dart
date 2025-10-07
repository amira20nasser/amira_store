import 'package:flutter/material.dart';

import 'category_section.dart';
import 'text_and_textbutton_inrow.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextAndTextButtonInRow(
          text: "Amira's Top Categories",
          onPressed: () {},
          textButton: "View All",
        ),

        // Category Section
        Expanded(child: CategorySection()),
      ],
    );
  }
}
