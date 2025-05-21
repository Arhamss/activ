import 'package:activ/activ/features/onboarding_flow/presentation/widgets/intro_widget.dart';
import 'package:activ/exports.dart';
import 'package:activ/l10n/localization_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
    _controller.addListener(() {
      final page = _controller.page?.round() ?? 0;
      if (_currentPageIndex != page) {
        setState(() {
          _currentPageIndex = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                IntroductionWidget(
                  imagePath: AssetPaths.intro1,
                  title: Localization.intro1Title,
                  description: Localization.intro1Description,
                ),
                IntroductionWidget(
                  imagePath: AssetPaths.intro2,
                  title: Localization.intro2Title,
                  description: Localization.intro2Description,
                ),
                IntroductionWidget(
                  imagePath: AssetPaths.intro3,
                  title: Localization.intro3Title,
                  description: Localization.intro3Description,
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: const ExpandingDotsEffect(
              dotWidth: 8,
              dotHeight: 8,
              activeDotColor: AppColors.primaryColor,
              dotColor: AppColors.inactiveProgressBar,
              spacing: 4,
              expansionFactor: 2,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ActivButton(
                onPressed: () {
                  if (_currentPageIndex < 2) {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  } else {
                    context.goNamed(AppRouteNames.signUpScreen);
                  }
                },
                text: (_currentPageIndex < 2)
                    ? Localization.nextText
                    : Localization.getStartedText,
                isLoading: false,
              ),
              ActivButton(
                backgroundColor: AppColors.secondaryColor,
                onPressed: () {
                  context.goNamed(AppRouteNames.signUpScreen);
                },
                text: Localization.skipText,
                isLoading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
