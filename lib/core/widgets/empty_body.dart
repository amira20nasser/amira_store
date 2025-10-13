import 'package:flutter/material.dart';

import '../constants/image_assets.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.msg});
  final String msg;
  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          brightness == Brightness.light
              ? Assets.assetsImagesNoResult
              : Assets.assetsImagesNoResultDarkTheme,
          height: 250,
        ),
        Text(
          msg,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
