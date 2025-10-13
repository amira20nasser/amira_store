import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/di_imports.dart';
import '../../core/widgets/custom_app_bar.dart';
import 'domain/usecases/search_products_usecase.dart';
import 'presentation/manager/search_products_cubit.dart';
import 'presentation/widgets/search_result_widget.dart';
import 'search_widget.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchProductsCubit(ServiceLocator.get<SearchProductsUsecase>()),
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBar(
              appBarHeight: 180,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(FontAwesomeIcons.angleLeft),
                      ),
                      Text(
                        "Search results",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.filter),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(child: SearchWidget()),
                ],
              ),
            ),

            //DONE: RESULT SEARCH
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: SearchResultsWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
