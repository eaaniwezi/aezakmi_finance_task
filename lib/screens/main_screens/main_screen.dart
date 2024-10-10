// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:aezakmi_finance_task/screens/fin_goals_screens/add_goals_screen.dart';
import 'package:aezakmi_finance_task/screens/home_screens/add_transaction_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;
import 'package:aezakmi_finance_task/controllers/bottom_navbar_controller.dart';
import 'package:aezakmi_finance_task/screens/main_screens/settings_screen.dart';
import 'package:aezakmi_finance_task/screens/main_screens/financial_goals_screen.dart';
import 'package:aezakmi_finance_task/screens/main_screens/financial_budget_screen.dart';

class MainScreen extends StatelessWidget {
  final BottomNavController _controller = Get.put(BottomNavController());

  final List<Widget> _pages = [
    FinancialBudgetScreen(),
    FinancialGoalsScreen(),
    SettingsScreen(),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.ColorTheme.lightLemonColor,
      body: Obx(() => _pages[_controller.selectedIndex.value]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 54,
              decoration: BoxDecoration(
                color: style.ColorTheme.blackColor,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(
                        iconPath: "assets/icons/home.svg",
                        label: "Home",
                        index: 0,
                      ),
                      _buildNavItem(
                        iconPath: "assets/icons/money.svg",
                        label: "Goals",
                        index: 1,
                      ),
                      _buildNavItem(
                        iconPath: "assets/icons/settings.svg",
                        label: "Setting",
                        index: 2,
                      ),
                    ],
                  )),
            ),
            Obx(() {
              return _controller.selectedIndex.value != 2
                  ? CircleAvatar(
                      radius: 30,
                      backgroundColor: style.ColorTheme.blackColor,
                      child: IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          if (_controller.selectedIndex.value == 0) {
                            Get.to(() => AddTransactionScreen());
                          }
                          if (_controller.selectedIndex.value == 1) {
                            Get.to(() => AddGoalsScreen());
                          }
                        },
                      ),
                    )
                  : SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      {required String iconPath, required String label, required int index}) {
    final bool isSelected = _controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () => _controller.changePage(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              color: isSelected
                  ? style.ColorTheme.blackColor
                  : style.ColorTheme.lightGreyColor,
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  label,
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
