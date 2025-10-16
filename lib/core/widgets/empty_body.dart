import 'package:flutter/material.dart';

import '../constants/image_assets.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.msg, this.imagePath});
  final String msg;
  final String? imagePath;
  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath ??
              (brightness == Brightness.light
                  ? Assets.assetsImagesNoResult
                  : Assets.assetsImagesNoResultDarkTheme),
          height: 200,
        ),
        Text(
          msg,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
