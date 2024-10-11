// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;

class CustomRatingBarWidget extends StatelessWidget {
  final double percentValue;
  CustomRatingBarWidget({required this.percentValue});

  @override
  Widget build(BuildContext context) {
    int filledContainers = (percentValue * 10).toInt();
    return Row(
      children: List.generate(10, (index) {
        bool isFilled = index < filledContainers;
        return Container(
          margin: EdgeInsets.only(right: 3),
          height: 11,
          width: 11,
          decoration: BoxDecoration(
            color: isFilled ? style.ColorTheme.lemonColor : Colors.white,
            border: Border.all(
              color: style.ColorTheme.blackColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
        );
      }),
    );
  }
}
