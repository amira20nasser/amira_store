import 'package:flutter/material.dart';

void main() {
  runApp(const AmiraStore());
}

class AmiraStore extends StatelessWidget {
  const AmiraStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
