import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_sizes.dart';

class GoogleFacebookInRow extends StatelessWidget {
  const GoogleFacebookInRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.google)),
        SizedBox(width: AppSizes.defaultPadding),
        IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.facebookF)),
      ],
    );
  }
}
