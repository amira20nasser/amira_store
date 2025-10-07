import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth/presentation/widgets/custom_text_field.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextField(
        controller: TextEditingController(),
        hintText: "Search product..",
        icon: FontAwesomeIcons.magnifyingGlass,
        onChanged: (value) {},
        suffixIcon: TextEditingController().text.isNotEmpty == true
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  TextEditingController().clear();
                },
              )
            : null,
      ),
    );
  }
}
