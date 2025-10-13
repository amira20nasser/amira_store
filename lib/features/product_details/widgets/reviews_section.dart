import 'package:flutter/material.dart';
import '../../home/domain/entities/product_entity.dart';
import 'bottom_sheet_body.dart';
import 'review_card.dart';

class ReviewsSection extends StatefulWidget {
  final List<ReviewEntity> reviews;
  final int productId;
  const ReviewsSection({
    super.key,
    required this.reviews,
    required this.productId,
  });

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  late ValueNotifier<List<ReviewEntity>> reviewsNotifier;
  @override
  void initState() {
    super.initState();
    reviewsNotifier = ValueNotifier(widget.reviews);
  }

  void _showAddReviewDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return InkWell(
          onTap: () => FocusScope.of(context).unfocus(),
          child: BottomSheetBody(
            productId: widget.productId,
            reviewsNotifier: reviewsNotifier,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Customer Reviews',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton.icon(
                onPressed: _showAddReviewDialog,
                icon: const Icon(Icons.add_comment_rounded),
                label: const Text('Add Review'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder(
            valueListenable: reviewsNotifier,
            builder: (context, List<ReviewEntity> reviews, _) {
              if (reviews.isEmpty) {
                return const Text('No reviews yet. Be the first to add one!');
              }
              return Column(
                children: [...reviews.map((review) => ReviewCard(review))],
              );
            },
          ),
        ],
      ),
    );
  }
}
