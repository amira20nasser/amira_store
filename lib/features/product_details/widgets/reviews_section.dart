import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../home/domain/entities/product_entity.dart';

//TODO Refactor this Widgets
class ReviewsSection extends StatefulWidget {
  final List<ReviewEntity> reviews;

  const ReviewsSection({super.key, required this.reviews});

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  final TextEditingController _commentController = TextEditingController();
  int _selectedRating = 0;

  void _showAddReviewDialog() {
    _commentController.clear();
    _selectedRating = 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Add Your Review'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rating',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(5, (index) {
                    final starIndex = index + 1;
                    return IconButton(
                      icon: Icon(
                        Icons.star,
                        color: _selectedRating >= starIndex
                            ? Colors.amber
                            : Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setState(() => _selectedRating = starIndex);
                      },
                    );
                  }),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _commentController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Write your comment...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _submitReview,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _submitReview() {
    if (_commentController.text.isEmpty || _selectedRating == 0) return;

    final newReview = ReviewEntity(
      reviewerName: 'You',
      reviewDate: DateTime.now(),
      rating: _selectedRating,
      comment: _commentController.text,
    );

    setState(() {
      widget.reviews.insert(0, newReview);
    });

    context.pop(context); // close dialog
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Title Row with Button ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Customer Reviews',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: _showAddReviewDialog,
                icon: const Icon(Icons.add_comment_rounded, size: 20),
                label: const Text('Add Review'),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // --- Existing Reviews ---
          if (widget.reviews.isEmpty)
            const Text('No reviews yet. Be the first to add one!')
          else
            ...widget.reviews.map((review) => _buildReviewCard(review)),
        ],
      ),
    );
  }

  Widget _buildReviewCard(ReviewEntity review) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          review.reviewerName,
          style: const TextStyle(fontWeight: FontWeight.bold),
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
                  size: 18,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(review.comment),
            const SizedBox(height: 4),
            Text(
              '${review.reviewDate.day}/${review.reviewDate.month}/${review.reviewDate.year}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
