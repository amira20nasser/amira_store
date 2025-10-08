import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/di_imports.dart';
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
              CategoryCubit(ServiceLocator.get<FetchCategoriesUseCase>())
                ..loadCategories(),
        ),
        BlocProvider(
          create: (context) =>
              HomeCubit(ServiceLocator.get<FetchSelectedCategoriesUsecase>())
                ..fetchSelectedCategories(),
        ),
      ],
      child: child,
    );
  }
}
