import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class AutoScrollCarouselView extends StatefulWidget {
  const AutoScrollCarouselView({
    super.key,
    required this.items,
    this.onTapChild,
    this.maxHeight,
  });
  final List<Widget> items;
  final Function(int)? onTapChild;
  final double? maxHeight;
  @override
  State<AutoScrollCarouselView> createState() => _AutoScrollCarouselViewState();
}

class _AutoScrollCarouselViewState extends State<AutoScrollCarouselView> {
  final CarouselController _scrollController = CarouselController();
  int _currentIndex = 0;
  late int _itemCount;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _itemCount = widget.items.length;
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      final double itemWidth = MediaQuery.of(context).size.width * 0.9;
      _currentIndex = (_currentIndex + 1) % _itemCount;

      _scrollController.animateTo(
        _currentIndex * itemWidth,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.maxHeight ?? MediaQuery.of(context).size.height * 0.4,
      ),
      child: CarouselView(
        onTap: widget.onTapChild,
        backgroundColor: AppColors.primaryMaterialColor.shade100.withValues(
          alpha: 0.3,
        ),
        controller: _scrollController,
        itemExtent: _itemCount != 1
            ? MediaQuery.of(context).size.width * 0.9
            : MediaQuery.of(context).size.width,
        shrinkExtent: 250,
        scrollDirection: Axis.horizontal,
        children: widget.items,
      ),
    );
  }
}
