// ignore_for_file: prefer_const_constructors
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aezakmi_finance_task/models/transcation_model.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;

class TransactionHistoryCard extends StatelessWidget {
  final TranscationModel model;
  const TransactionHistoryCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: style.ColorTheme.blackColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset(
                model.selectedCategory.svgPath.toString(),
              ),
            ),
          ),
          SizedBox(width: 14),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.selectedCategory.name.toString(),
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  color: style.ColorTheme.blackColor,
                ),
              ),
              Text(
                model.timing,
                style: GoogleFonts.spaceGrotesk(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: style.ColorTheme.darkGreyColor,
                ),
              ),
            ],
          ),
          //
          Spacer(),
          Text(
            model.isCost
                // ? '— \$ ${model.amount.abs()}'
                // : '+ \$ ${model.amount.abs()}',
                ? '— \$ ${NumberFormat.compact().format(model.amount.abs())}'
                : '+ \$ ${NumberFormat.compact().format(model.amount.abs())}',
            style: GoogleFonts.spaceGrotesk(
              fontWeight: FontWeight.w700,
              fontSize: 26,
              fontStyle: FontStyle.normal,
              color: model.isCost
                  ? style.ColorTheme.darkGreyColor
                  : style.ColorTheme.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
