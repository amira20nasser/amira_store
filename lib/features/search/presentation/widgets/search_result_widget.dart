import 'package:flutter/material.dart';

import 'search_products_bloc_builder.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [SearchProductsBlocBuilder()]);
  }
}
