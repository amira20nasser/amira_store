import 'package:amira_store/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../categories/domain/usecases/fetch_category.dart';
import '../../../categories/presentation/manager/category_cubit.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryCubit(ServiceLocator.get<FetchCategoriesUseCase>())
            ..loadCategories(),
      child: Column(
        children: [
          CustomAppBar(appBarHeight: 140, child: HomeAppBar()),
          Expanded(child: HomeBody()),
        ],
      ),
    );
  }
}
