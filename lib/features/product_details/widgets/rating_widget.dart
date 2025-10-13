import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.selectedRating});
  final ValueNotifier<int> selectedRating;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedRating,
      builder: (context, value, widget) => Row(
        children: List.generate(5, (index) {
          final starIndex = index + 1;
          return IconButton(
            iconSize: 28,
            icon: Icon(
              Icons.star,
              color: value >= starIndex ? Colors.amber : Colors.grey.shade400,
            ),
            onPressed: () {
              selectedRating.value = starIndex;
            },
          );
        }),
      ),
    );
  }
}
