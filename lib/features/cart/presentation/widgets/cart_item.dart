import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/formatter.dart';
import '../../../../core/widgets/snack_bar.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../manager/cart_action_button_cubit.dart/cart_action_button_cubit.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.item});

  final CartItemEntity item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.blackColor80),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${formatMoney(item.price)}',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  color: item.quantity == item.minOrder
                      ? AppColors.blackColor60
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: item.quantity > item.minOrder
                      ? () async {
                          int q = item.quantity;
                          await context
                              .read<CartActionButtonCubit>()
                              .updateCartItemQuantity(item, q - 1);
                        }
                      : () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBarTypes.warningSnackBar(
                            message:
                                '${item.name} min order Quantity is ${item.minOrder}',
                          ),
                        ),
                ),
                Text(
                  '${item.quantity}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  color: item.quantity > 100 ? AppColors.blackColor60 : null,
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: item.quantity >= item.minOrder
                      ? () async {
                          int q = item.quantity;
                          await context
                              .read<CartActionButtonCubit>()
                              .updateCartItemQuantity(item, q + 1);
                        }
                      : () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBarTypes.warningSnackBar(
                            message:
                                '${item.name} min order Quantity is ${item.minOrder}',
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
