import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/di_imports.dart';
import '../../core/network/network_cubit.dart';
import '../../core/widgets/snack_bar.dart';
import '../cart/domain/repos/cart_repo.dart';
import '../cart/presentation/manager/cart_action_button_cubit.dart/cart_action_button_cubit.dart';
import '../cart/presentation/manager/cart_items_cubit/cart_items_cubit.dart';
import '../categories/domain/usecases/fetch_category.dart';
import '../categories/presentation/manager/category_cubit.dart';
import '../home/domain/usecases/fetch_product_by_category_usecase.dart';
import '../home/presentation/manager/home_cubit.dart';

class MainViewMultiBloc extends StatelessWidget {
  const MainViewMultiBloc({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CartItemsCubit(ServiceLocator.get<CartRepo>())..getCartItems(),
        ),
        BlocProvider(
          create: (context) =>
              CartActionButtonCubit(ServiceLocator.get<CartRepo>()),
        ),
        BlocProvider(
          create: (context) =>
              CategoryCubit(ServiceLocator.get<FetchCategoriesUseCase>())
                ..loadCategories(),
        ),
        BlocProvider(
          create: (context) =>
              HomeCubit(ServiceLocator.get<FetchSelectedCategoriesUsecase>())
                ..fetchSelectedCategories(),
        ),
      ],
      child: BlocListener<NetworkCubit, NetworkState>(
        listener: (context, state) {
          if (state is NetworkDisconnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarTypes.warningSnackBar(message: 'You are offline'),
            );
          } else if (state is NetworkConnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBarTypes.successSnackBar(
                message: 'You\'re online — syncing cart...',
              ),
            );
          }
        },
        child: BlocListener<CartActionButtonCubit, CartActionButtonState>(
          listener: (context, state) {
            if (state is SuccessfulCartActionButton) {
              BlocProvider.of<CartItemsCubit>(context).getCartItems();
            } else if (state is FailedCartActionButton) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBarTypes.warningSnackBar(message: state.msg));
            }
          },
          child: child,
        ),
      ),
    );
  }
}
