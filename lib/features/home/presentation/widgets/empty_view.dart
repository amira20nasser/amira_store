import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No categories available.",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}
