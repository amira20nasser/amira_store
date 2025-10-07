import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String message;

  const ErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Error: $message",
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
      ),
    );
  }
}
