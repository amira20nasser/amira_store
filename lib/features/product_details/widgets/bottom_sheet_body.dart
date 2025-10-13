import 'package:amira_store/core/utils/logging/logger_helper.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../auth/presentation/widgets/custom_text_field.dart';
import '../../home/domain/entities/product_entity.dart';
import 'bottom_sheet_action.dart';
import 'rating_widget.dart';

class BottomSheetBody extends StatefulWidget {
  const BottomSheetBody({
    super.key,
    required this.productId,
    required this.reviewsNotifier,
  });
  final int productId;
  final ValueNotifier<List<ReviewEntity>> reviewsNotifier;
  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {
  final TextEditingController _commentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ValueNotifier<int> selectedRating = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    LoggerHelper.debug((MediaQuery.sizeOf(context).width - 100).toString());
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width - 30,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Divider(
                    thickness: 5,
                    endIndent: MediaQuery.sizeOf(context).width - 300,
                    indent: MediaQuery.sizeOf(context).width - 300,
                    radius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Add Your Review',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Text('Rating', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                RatingWidget(selectedRating: selectedRating),
                const SizedBox(height: 8),
                CustomTextField(
                  fillColor: AppColors.primaryMaterialColor.shade100.withValues(
                    alpha: 0.4,
                  ),
                  controller: _commentController,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  hintText: 'Write your comment...',
                  maxLines: 3,
                  hintStyle: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 16),
                BottomSheetActions(
                  commentController: _commentController,
                  selectedRating: selectedRating,
                  formKey: _formKey,
                  widget: widget,
                ),

                const SizedBox(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
