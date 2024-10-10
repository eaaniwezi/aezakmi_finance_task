// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;
import 'package:aezakmi_finance_task/controllers/fin_goals_controller.dart';
import 'package:aezakmi_finance_task/screens/fin_goals_screens/edit_goals_screen.dart';
import 'package:aezakmi_finance_task/screens/fin_goals_screens/add_history_screen.dart';

class FinancialGoalsScreen extends StatelessWidget {
  final _controller = Get.put(FinancialGoalsController());
  FinancialGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: style.ColorTheme.lightLemonColor,
        body: Obx(() {
          var goals = _controller.financialGoals;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                _header(),
                const SizedBox(height: 30),
                goals.isEmpty
                    ? Image.asset("assets/pics/jar_money.png")
                    : SizedBox.shrink(),
                goals.isEmpty
                    ? Align(
                        child: _textContainer(
                            "There are no goals\nfor saving money"))
                    : SizedBox.shrink(),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: goals.length,
                    itemBuilder: (_, index) {
                      var model = goals[index];

                      double percentValue = 0.0;
                      // if (model.amount > 0) {
                      //   percentValue = (model.availableAmount / model.amount);
                      // }

                      if (model.percentValue != null) {
                        percentValue = model.percentValue!.clamp(0.0, 1.0);
                      } else {
                        percentValue = 0.0;
                      }

                      return GestureDetector(
                        onTap: () {
                          // Get.to(() => EditGoalsScreen(model: model));
                          Get.to(() => AddHistoryScreen(model: model));
                        },
                        child: Container(
                          height: 108,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 108,
                                width: 108,
                                decoration: BoxDecoration(
                                  color: style.ColorTheme.blackColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: CircularPercentIndicator(
                                  radius: 40.0,
                                  lineWidth: 5.0,
                                  percent: percentValue,
                                  center: _percentText(
                                    model.percentValue == null
                                        ? "0%"
                                        : "${model.percentValue.toString()}%",
                                    // "${(percentValue * 100).toStringAsFixed(0)}%",
                                  ), // Display percentage
                                  progressColor: style.ColorTheme.lemonColor,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RatingBarIndicator(
                                        rating: model.priority,
                                        itemCount: 5,
                                        itemSize: 20,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: style.ColorTheme.lemonColor,
                                        ),
                                      ),
                                      _titleContainer(model.title),
                                      _dateContainer(
                                          label: "Start:",
                                          title: model.startDate),
                                      _dateContainer(
                                          label: "End:", title: model.endDate),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          );
        }));
  }

  _dateContainer({required String label, required String title}) {
    return Row(
      children: [
        _dateText(label),
        SizedBox(width: 33),
        _dateText(title),
      ],
    );
  }

  _percentText(text) {
    return Text(
      text,
      style: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w400,
        fontSize: 24,
        fontStyle: FontStyle.normal,
        color: Colors.white,
      ),
    );
  }

  _dateText(text) {
    return Text(
      text,
      style: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        fontStyle: FontStyle.normal,
        color: style.ColorTheme.blackColor,
      ),
    );
  }

  _titleContainer(label) {
    return Text(
      label,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        fontStyle: FontStyle.normal,
        color: style.ColorTheme.blackColor,
      ),
    );
  }

  _textContainer(label) {
    return Text(
      label,
      style: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w700,
        fontSize: 26,
        fontStyle: FontStyle.normal,
        color: style.ColorTheme.blackColor,
      ),
    );
  }

  _header() {
    return Text(
      "\nFinancial goals",
      style: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w700,
        fontSize: 42,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}
