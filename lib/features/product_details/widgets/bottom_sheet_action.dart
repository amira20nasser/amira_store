import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/di_imports.dart';
import '../../../core/services/firebase_service.dart';
import '../../../core/widgets/snack_bar.dart';
import '../../home/domain/entities/product_entity.dart';
import 'bottom_sheet_body.dart';

class BottomSheetActions extends StatelessWidget {
  const BottomSheetActions({
    super.key,
    required TextEditingController commentController,
    required this.selectedRating,
    required GlobalKey<FormState> formKey,
    required this.widget,
  }) : _commentController = commentController,
       _formKey = formKey;

  final TextEditingController _commentController;
  final ValueNotifier<int> selectedRating;
  final GlobalKey<FormState> _formKey;
  final BottomSheetBody widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // TODO add to Firebase store
              // product id with customer id
              // save date , rate ,comment
              if (_commentController.text.isEmpty ||
                  selectedRating.value == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBarTypes.warningSnackBar(
                    message: 'Please provide a rating and comment.',
                  ),
                );
                return;
              }

              if (_formKey.currentState?.validate() ?? false) {
                final user =
                    ServiceLocator.get<FirebaseAuthService>().currentUser;
                String name = 'Guest';
                String userId = 'guest_id';

                if (user != null) {
                  name = user.displayName!;
                  userId = user.uid;
                }
                final newReview = ReviewEntity(
                  reviewerName: name,
                  reviewerId: userId,
                  reviewDate: DateTime.now(),
                  rating: selectedRating.value,
                  comment: _commentController.text.trim(),
                );
                widget.reviewsNotifier.value = [
                  newReview,
                  ...widget.reviewsNotifier.value,
                ];
                context.pop(context);
              }
            },

            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }
}
