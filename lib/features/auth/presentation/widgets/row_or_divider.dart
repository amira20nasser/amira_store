import 'package:flutter/material.dart';

class RowOrDivider extends StatelessWidget {
  const RowOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Divider(endIndent: 10, indent: 10)),
        Text("OR"),
        Expanded(child: Divider(indent: 10, endIndent: 10)),
      ],
    );
  }
}
