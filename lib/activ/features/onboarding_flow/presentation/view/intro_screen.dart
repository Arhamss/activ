import 'package:activ/activ/features/onboarding_flow/presentation/widgets/intro_widget.dart';
import 'package:activ/exports.dart';
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
              children: const [
                IntroductionWidget(
                  imagePath: AssetPaths.intro1,
                  title: ' Explore City and Nearby Sport Clubs',
                  description:
                      'Discover sports clubs and facilities around you to join games, train, and stay active.',
                ),
                IntroductionWidget(
                  imagePath: AssetPaths.intro2,
                  title: ' Choose your sport and Explore Club',
                  description:
                      'Pick your favorite sport and find the best clubs to play and connect',
                ),
                IntroductionWidget(
                  imagePath: AssetPaths.intro3,
                  title: 'Select Slot and make a Reservation',
                  description:
                      'Pick your preferred time and book your place with ease',
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
              activeDotColor: AppColors.secondaryBlue,
              dotColor: AppColors.inactiveProgressBar,
              spacing: 4,
              expansionFactor: 2,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              24,
              0,
              24,
              8,
            ),
            child: ActivButton(
              borderRadius: 15,
              onPressed: () {
                if (_currentPageIndex < 2) {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                } else {
                  context.goNamed(AppRouteNames.signInScreen);
                }
              },
              text: (_currentPageIndex < 2) ? 'Next' : 'Get Started',
              isLoading: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              0,
              24,
              MediaQuery.of(context).size.height * 0.1,
            ),
            child: ActivButton(
              backgroundColor: AppColors.secondaryColor,
              borderRadius: 15,
              onPressed: () {
                context.goNamed(AppRouteNames.signInScreen);
              },
              text: 'Skip',
              isLoading: false,
            ),
          ),
        ],
      ),
    );
  }
}
