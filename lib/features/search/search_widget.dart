import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constants/app_colors.dart';
import '../auth/presentation/widgets/custom_text_field.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextField(
        fillColor: AppColors.whiteColor.withValues(alpha: 0.5),
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
