import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';

class OnBoardTitleDescription extends StatelessWidget {
  const OnBoardTitleDescription({
    super.key,
    required this.title,
    required this.description,
  });

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: AppSizes.defaultPadding),
        Text(description, textAlign: TextAlign.center),
      ],
    );
  }
}
