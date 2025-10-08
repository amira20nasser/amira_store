import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/shared_pref_keys.dart';
import '../../../../core/services/shared_preferences_service.dart';
import '../../../../core/widgets/dot_indicator.dart';
import '../../domain/entities/on_boarding_entity.dart';
import '../widgets/on_boarding_content.dart';
import '../widgets/text_button_skip.dart';

class OnBordingView extends StatefulWidget {
  const OnBordingView({super.key, required this.onBoardingItems});
  final List<OnBoardingEntity> onBoardingItems;
  @override
  State<OnBordingView> createState() => _OnBordingViewState();
}

class _OnBordingViewState extends State<OnBordingView> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.defaultPadding,
          ),
          child: Column(
            children: [
              Align(alignment: Alignment.topRight, child: TextButtonSkip()),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.onBoardingItems.length,
                  onPageChanged: (value) {
                    setState(() {
                      _pageIndex = value;
                    });
                  },
                  itemBuilder: (context, index) => OnBordingPageViewContent(
                    title: widget.onBoardingItems[index].title,
                    description: widget.onBoardingItems[index].description,
                    image: (Theme.of(context).brightness == Brightness.dark)
                        ? widget.onBoardingItems[index].imageDarkTheme
                        : widget.onBoardingItems[index].image,
                    isTextOnTop: index.isOdd,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    widget.onBoardingItems.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(
                        right: AppSizes.defaultPadding / 4,
                      ),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_pageIndex < widget.onBoardingItems.length - 1) {
                          _pageController.nextPage(
                            curve: Curves.ease,
                            duration: AppSizes.defaultDuration,
                          );
                        } else {
                          var router = GoRouter.of(context);
                          final prefs = SharedPreferencesService();
                          await prefs.setBool(
                            SharedPrefKeys.onboardingSeen,
                            true,
                          );

                          router.pushReplacement(ConstantRoutes.login);
                        }
                      },
                      style: ElevatedButton.styleFrom(shape: CircleBorder()),
                      child: Icon(FontAwesomeIcons.chevronRight),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
