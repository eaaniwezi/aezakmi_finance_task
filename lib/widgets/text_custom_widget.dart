// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextCustomWidget extends StatelessWidget {
  final String hintText;
  final bool isAmount;
  final TextEditingController controller;
  const TextCustomWidget({
    super.key,
    required this.hintText,
    required this.isAmount,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        style: GoogleFonts.spaceGrotesk(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontStyle: FontStyle.normal,
          color: Colors.black,
        ),
        controller: controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontStyle: FontStyle.normal,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 12),
        ),
        keyboardType: isAmount
            ? TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
      ),
    );
  }
}

class DateCustomWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String hintText;
  final TextEditingController controller;

  const DateCustomWidget({
    super.key,
    required this.onTap,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onTap: onTap,
        style: GoogleFonts.spaceGrotesk(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontStyle: FontStyle.normal,
          color: Colors.black,
        ),
        controller: controller,
        cursorColor: Colors.black,
        readOnly: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontStyle: FontStyle.normal,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 12),
        ),
      ),
    );
  }
}
