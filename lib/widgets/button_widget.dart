import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;

class ButtonWidget extends StatelessWidget {
  final String label;
  final bool isColored;
  final Function function;
  const ButtonWidget({
    super.key,
    required this.label,
    required this.isColored,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        height: 49,
        decoration: BoxDecoration(
          color: isColored ? style.ColorTheme.lemonColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.spaceGrotesk(
              fontWeight: FontWeight.w700,
              fontSize: 26,
              fontStyle: FontStyle.normal,
              color: isColored
                  ? style.ColorTheme.blackColor
                  : style.ColorTheme.darkGreyColor,
            ),
          ),
        ),
      ),
    );
  }
}
