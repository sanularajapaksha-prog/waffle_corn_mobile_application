import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../utils/onboarding_mock_data.dart';
import '../widgets/custom_button.dart';
import '../widgets/onboarding/onboarding_page_widget.dart';
import '../widgets/onboarding/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePrimaryAction() {
    final isLast = _page == OnboardingMockData.slides.length - 1;
    if (isLast) {
      Navigator.pushReplacementNamed(context, AppRoutes.signIn);
      return;
    }

    _controller.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _page == OnboardingMockData.slides.length - 1;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.signIn,
                    ),
                    child: const Text('Skip'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColors.line),
                    ),
                    child: Text(
                      '${_page + 1}/${OnboardingMockData.slides.length}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: OnboardingMockData.slides.length,
                  onPageChanged: (value) => setState(() => _page = value),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: OnboardingPageWidget(
                      slide: OnboardingMockData.slides[index],
                      index: index,
                    ),
                  ),
                ),
              ),
              PageIndicator(
                count: OnboardingMockData.slides.length,
                currentIndex: _page,
              ),
              const SizedBox(height: 22),
              PrimaryButton(
                label: isLast ? 'Get Started' : 'Next',
                onPressed: _handlePrimaryAction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
