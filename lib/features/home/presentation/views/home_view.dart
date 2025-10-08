import 'package:amira_store/features/home/presentation/manager/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/di_imports.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../categories/domain/usecases/fetch_category.dart';
import '../../../categories/presentation/manager/category_cubit.dart';
import '../../domain/usecases/fetch_product_by_category_usecase.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
      child: Column(
        children: [
          CustomAppBar(appBarHeight: 140, child: HomeAppBar()),
          Expanded(child: HomeBody()),
        ],
      ),
    );
  }
}
