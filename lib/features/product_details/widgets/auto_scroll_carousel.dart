import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import 'image_card.dart';

class AutoScrollCarousel extends StatefulWidget {
  const AutoScrollCarousel({super.key, required this.imageUrls});
  final List<String> imageUrls;
  @override
  State<AutoScrollCarousel> createState() => _AutoScrollCarouselState();
}

class _AutoScrollCarouselState extends State<AutoScrollCarousel> {
  final CarouselController _scrollController = CarouselController();
  int _currentIndex = 0;
  late int _itemCount; // number of images
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _itemCount = widget.imageUrls.length;
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
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      child: CarouselView(
        backgroundColor: AppColors.primaryMaterialColor.shade100.withValues(
          alpha: 0.3,
        ),
        controller: _scrollController,
        itemExtent: _itemCount != 1
            ? MediaQuery.of(context).size.width * 0.9
            : MediaQuery.of(context).size.width,
        shrinkExtent: 250,
        scrollDirection: Axis.horizontal,
        children: List.generate(
          _itemCount,
          (index) => ImageCard(imageUrl: widget.imageUrls[index]),
        ),
      ),
    );
  }
}
