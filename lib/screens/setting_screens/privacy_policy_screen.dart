// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable, prefer_const_constructors

import 'package:aezakmi_finance_task/widgets/custom_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.ColorTheme.lightLemonColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            CustomAppbarWidget(title: "Privacy Policy"),
            _textContainer(policy),
          ],
        ),
      ),
    );
  }

  String policy =
      "The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.\nHere is where you can list and ban behaviors and activities like:................";

  _textContainer(label) {
    return Text(
      label,
      style: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        fontStyle: FontStyle.normal,
        color: style.ColorTheme.blackColor,
      ),
    );
  }
}
