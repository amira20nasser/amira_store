import 'package:flutter/material.dart';

import 'on_boarding_with_title_description.dart';

class OnBordingPageViewContent extends StatelessWidget {
  const OnBordingPageViewContent({
    super.key,
    this.isTextOnTop = false,
    required this.title,
    required this.description,
    required this.image,
  });

  final bool isTextOnTop;
  final String title, description, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: isTextOnTop ? _textOnTopLayout() : _imageOnTopLayout(),
    );
  }

  List<Widget> _textOnTopLayout() => [
    const Spacer(),
    OnBoardTitleDescription(title: title, description: description),
    const Spacer(),
    Image.asset(image, height: 250),
    const Spacer(),
  ];
  List<Widget> _imageOnTopLayout() => [
    const Spacer(),
    Image.asset(image, height: 250),
    const Spacer(),
    OnBoardTitleDescription(title: title, description: description),
    const Spacer(),
  ];
}
