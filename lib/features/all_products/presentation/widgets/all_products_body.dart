import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/all_products_cubit.dart';
import 'all_products_bloc_builder.dart';

class AllProductsBody extends StatefulWidget {
  const AllProductsBody({super.key});

  @override
  State<AllProductsBody> createState() => _AllProductsBodyState();
}

class _AllProductsBodyState extends State<AllProductsBody> {
  late final ScrollController _controller;
  int nextPage = 1;
  var loading = false;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() async {
    var currentPosition = _controller.position.pixels;
    var maxScrollLength = _controller.position.maxScrollExtent;
    if (currentPosition >= 0.7 * maxScrollLength) {
      if (!loading) {
        loading = true;
        await BlocProvider.of<AllProductsCubit>(
          context,
        ).getProducts(pageNumber: nextPage);
        nextPage++;
        loading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: [AllProductsBlocBuilder()],
    );
  }
}
