import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbarWidget extends StatelessWidget {
  final String title;
  const CustomAppbarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 43),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset('assets/icons/back-arrow.svg')),
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          SvgPicture.asset(
            'assets/icons/back-arrow.svg',
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
