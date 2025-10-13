import 'package:flutter/material.dart';

import '../../../core/di/di_imports.dart';
import '../../../core/services/firebase_service.dart';
import '../../home/domain/entities/product_entity.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard(this.review, {super.key});
  final ReviewEntity review;
  @override
  Widget build(BuildContext context) {
    var currentUserId =
        ServiceLocator.get<FirebaseAuthService>().currentUser?.uid;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          review.reviewerId == currentUserId ? 'You' : review.reviewerName,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: index < review.rating
                      ? Colors.amber
                      : Colors.grey.shade300,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(review.comment, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 4),
            Text(
              '${review.reviewDate.day}/${review.reviewDate.month}/${review.reviewDate.year}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
