// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;
import 'package:aezakmi_finance_task/controllers/account_controller.dart';
import 'package:aezakmi_finance_task/screens/main_screens/main_screen.dart';
import 'package:aezakmi_finance_task/controllers/on_boarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountController = Get.put(AccountController());
    final OnboardingController controller = Get.put(OnboardingController());
    final PageController pageController = PageController();

    return Scaffold(
      backgroundColor: style.ColorTheme.lemonColor,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: controller.goToPage,
            children: [
              const OnboardingPage(
                  image: 'assets/pics/onboard_one.png',
                  title:
                      'Welcome to the app\nfor managing your\nfinances and savings!'),
              const OnboardingPage(
                  image: 'assets/pics/onboard_two.png',
                  title: 'Set financial goals.\nTrack expenses and\nincome'),
              const OnboardingPage(
                  image: 'assets/pics/onboard_three.png',
                  title:
                      'Start taking control\nof your finances and\nachieve your goals!'),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return controller.currentPageIndex.value == 2
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            onTap: () async {
                              await accountController.setFirstTimeUserFalse();
                              Get.offAll(() => MainScreen());
                            },
                            child: Text(
                              'Skip',
                              style: GoogleFonts.spaceGrotesk(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                height: 1.1,
                              ),
                            ),
                          );
                  }),
                  Obx(() {
                    return controller.isLastPage
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await accountController
                                      .setFirstTimeUserFalse();
                                  Get.offAll(() => MainScreen());
                                },
                                child: Text(
                                  "Let’s start!",
                                  style: GoogleFonts.spaceGrotesk(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: style.ColorTheme.blackColor,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward,
                                      color: Colors.white),
                                  onPressed: () async {
                                    await accountController
                                        .setFirstTimeUserFalse();
                                    Get.offAll(() => MainScreen());
                                  },
                                ),
                              ),
                            ],
                          )
                        : GestureDetector(
                            onTap: () {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: style.ColorTheme.blackColor,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;

  const OnboardingPage({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(image),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.w700,
                fontSize: 26,
                fontStyle: FontStyle.normal,
                height: 1.1,
                shadows: [
                  Shadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.25),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
