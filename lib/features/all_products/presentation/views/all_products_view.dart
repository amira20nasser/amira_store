import 'package:amira_store/core/di/di_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../manager/all_products_cubit.dart';
import '../widgets/all_products_body.dart';

class AllProductsView extends StatelessWidget {
  const AllProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AllProductsCubit(ServiceLocator.get<GetProductsUsecase>())
            ..getProducts(),
      child: Column(
        children: [
          CustomAppBar(
            appBarHeight: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                Text(
                  "All Products",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(FontAwesomeIcons.filter),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: AllProductsBody(),
            ),
          ),
        ],
      ),
    );
  }
}
