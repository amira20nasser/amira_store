import 'package:flutter/material.dart';

class InfoInRow extends StatelessWidget {
  const InfoInRow(this.label, this.value, {super.key});
  final String label, value;
  @override
  Widget build(BuildContext context) {
    if (value.toString().isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Flexible(child: Text(value.toString(), textAlign: TextAlign.end)),
        ],
      ),
    );
  }
}
