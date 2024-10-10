import 'package:aezakmi_finance_task/screens/main_screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;
import 'package:get/get.dart';
import 'package:aezakmi_finance_task/controllers/account_controller.dart';
import 'package:aezakmi_finance_task/screens/intro_screens/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the AccountController
    final accountController = Get.find<AccountController>();

    // This will check if it's the first time user and navigate accordingly
    Future.delayed(const Duration(seconds: 2), () async {
      bool isFirstTime = await accountController.isFirstTimeUserFlag() ?? true;
      if (isFirstTime) {
        Get.offAll(OnboardingScreen());
      } else {
        Get.offAll(MainScreen());
      }
    });

    return Scaffold(
      backgroundColor: style.ColorTheme.lightLemonColor,
      body: Center(
        child: Text(
          "Welcome",
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w700,
            fontSize: 26,
            fontStyle: FontStyle.normal,
            height: 1.1,
            shadows: [
              Shadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
