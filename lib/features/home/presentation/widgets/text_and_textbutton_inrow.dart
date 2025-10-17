import 'package:flutter/material.dart';

class TextAndTextButtonInRow extends StatelessWidget {
  const TextAndTextButtonInRow({
    super.key,
    required this.text,
    required this.textButton,
    required this.onPressed,
  });
  final String text, textButton;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: Theme.of(context).textTheme.bodyLarge),
          TextButton(onPressed: onPressed, child: Text(textButton)),
        ],
      ),
    );
  }
}
