import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/image_assets.dart';

class LoadingBody extends StatelessWidget {
  const LoadingBody({super.key, required this.msg});
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(Assets.assetsImagesLoading),
        Text(msg, style: Theme.of(context).textTheme.headlineMedium),
      ],
    );
  }
}
