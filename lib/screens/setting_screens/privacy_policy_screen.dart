// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;
import 'package:aezakmi_finance_task/widgets/custom_appbar_widget.dart';

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
            const CustomAppbarWidget(title: "Privacy Policy"),
            _textContainer(policy),
          ],
        ),
      ),
    );
  }

  // Updated policy text
  String policy =
      "The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.\n\n"
      "Here is where you can list and ban behaviors and activities like:\n\n"
      "• Obscene, crude, or violent posts\n"
      "• False or misleading content\n"
      "• Breaking the law\n"
      "• Spamming or scamming the service or other users\n"
      "• Hacking or tampering with your website or app\n"
      "• Violating copyright laws\n"
      "• Harassing other users\n"
      "• Stalking other users\n\n"
      "If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.\n\n"
      "The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.\n\n"
      "Here is where you can list and ban behaviors and activities like:\n\n"
      "• Obscene, crude, or violent posts\n"
      "• False or misleading content\n"
      "• Breaking the law\n"
      "• Spamming or scamming the service or other users\n"
      "• Hacking or tampering with your website or app\n"
      "• Violating copyright laws\n"
      "• Harassing other users\n"
      "• Stalking other users\n\n"
      "If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.\n\n"
      "The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.\n\n"
      "Here is where you can list and ban behaviors and activities like:\n\n"
      "• Obscene, crude, or violent posts\n"
      "• False or misleading content\n"
      "• Breaking the law\n"
      "• Spamming or scamming the service or other users\n"
      "• Hacking or tampering with your website or app\n"
      "• Violating copyright laws\n"
      "• Harassing other users\n"
      "• Stalking other users\n\n"
      "If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.\n\n";

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
