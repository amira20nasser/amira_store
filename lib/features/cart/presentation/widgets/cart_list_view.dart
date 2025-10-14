import 'package:amira_store/core/formatter.dart';
import 'package:amira_store/core/widgets/snack_bar.dart';
import 'package:amira_store/features/cart/domain/entities/cart_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../manager/cart_cubit.dart';

class CartListView extends StatelessWidget {
  const CartListView({super.key, required this.cartItems});
  final List<CartItemEntity> cartItems;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];

        return Dismissible(
          key: ValueKey(item.id),
          background: Container(
            color: AppColors.errorColor,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            context.read<CartCubit>().removeItemFromCart(item.id.toString());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarTypes.warningSnackBar(message: '${item.name} removed'),
            );
          },
          child: Card(
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
                  // 🖼️ Product Image
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

                  // 📄 Product Info
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
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),

                  // 🔘 Quantity Controls
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: item.quantity > 1
                            ? () {
                                int q = item.quantity;
                                context
                                    .read<CartCubit>()
                                    .updateCartItemQuantity(
                                      item.id.toString(),
                                      q - 1,
                                    );
                              }
                            : () => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBarTypes.warningSnackBar(
                                  message:
                                      '${item.name} max order Quantity is 20',
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
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: item.quantity < item.minOrder
                            ? () {
                                int q = item.quantity;
                                context
                                    .read<CartCubit>()
                                    .updateCartItemQuantity(
                                      item.id.toString(),
                                      q + 1,
                                    );
                              }
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
