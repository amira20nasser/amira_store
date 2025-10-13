import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constants/app_colors.dart';
import '../auth/presentation/widgets/custom_text_field.dart';
import 'presentation/manager/search_products_cubit.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchProductsCubit>().searchProducts(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextField(
        fillColor: AppColors.whiteColor.withValues(alpha: 0.5),
        textInputAction: TextInputAction.search,
        controller: _searchController,
        hintText: "Search product..",
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        icon: FontAwesomeIcons.magnifyingGlass,
        onChanged: _onSearchChanged,
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                },
              )
            : null,
      ),
    );
  }
}
