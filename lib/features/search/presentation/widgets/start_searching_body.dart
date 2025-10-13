import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/image_assets.dart';

class StartSearchingBody extends StatelessWidget {
  const StartSearchingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(Assets.assetsImagesIconsSearch),
        Text(
          'Start searching for products',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
