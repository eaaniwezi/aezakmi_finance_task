// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;
import 'package:aezakmi_finance_task/screens/setting_screens/privacy_policy_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.ColorTheme.lightLemonColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            _header(),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _items(
                  label: items[index]["label"],
                  onTap: items[index]["onTap"],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> items = [
    {
      "label": "Version",
      "onTap": () {
        Get.snackbar('INFO', 'No UI AVAILABLE');
      }
    },
    {
      "label": "Rate us",
      "onTap": () {
        Get.snackbar('INFO', 'No UI AVAILABLE');
      }
    },
    {
      "label": "Terms of Use",
      "onTap": () {
        Get.snackbar('INFO', 'No UI AVAILABLE');
      }
    },
    {
      "label": "About us",
      "onTap": () {
        Get.snackbar('INFO', 'No UI AVAILABLE');
      }
    },
    {
      "label": "Privacy Policy",
      "onTap": () {
        Get.to(() => PrivacyPolicyScreen());
      }
    },
  ];

  _header() {
    return Text(
      "\nSetting",
      style: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w700,
        fontSize: 42,
        fontStyle: FontStyle.normal,
      ),
    );
  }

  _items({
    required String label,
    required Function onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Row(
              children: [
                Text(
                  label,
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Spacer(),
                SvgPicture.asset("assets/icons/square-arrow.svg")
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: style.ColorTheme.lemonColor,
          )
        ],
      ),
    );
  }
}
