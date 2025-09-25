import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_colors.dart';

class PasswordChecksWidget extends StatelessWidget {
  final ValueNotifier<Map<String, bool>> passwordChecks;
  const PasswordChecksWidget({super.key, required this.passwordChecks});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, bool>>(
      valueListenable: passwordChecks,
      builder: (_, checks, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: checks.entries.map((entry) {
            final met = entry.value;
            return Container(
              padding: EdgeInsets.only(bottom: 3),
              child: Row(
                children: [
                  Icon(
                    met ? FontAwesomeIcons.circleCheck : FontAwesomeIcons.ban,
                    color: met ? AppColors.primaryColor : AppColors.errorColor,
                  ),
                  const SizedBox(width: 8),
                  Text(entry.key),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
