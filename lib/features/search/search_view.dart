import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/custom_app_bar.dart';
import 'presentation/widgets/search_result_widget.dart';
import 'search_widget.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        GoRouter.of(context).pop();
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
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SearchResultsWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
