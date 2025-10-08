import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.msg});
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(msg, style: TextStyle(fontSize: 16, color: Colors.grey)),
    );
  }
}
