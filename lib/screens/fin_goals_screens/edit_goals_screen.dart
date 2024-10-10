// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:aezakmi_finance_task/widgets/button_widget.dart';
import 'package:aezakmi_finance_task/models/fin_goals_model.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;
import 'package:aezakmi_finance_task/widgets/text_custom_widget.dart';
import 'package:aezakmi_finance_task/widgets/custom_appbar_widget.dart';
import 'package:aezakmi_finance_task/controllers/edit_goals_controller.dart';

class EditGoalsScreen extends StatefulWidget {
  final FinGoalsModel model;

  EditGoalsScreen({super.key, required this.model});

  @override
  State<EditGoalsScreen> createState() => _EditGoalsScreenState();
}

class _EditGoalsScreenState extends State<EditGoalsScreen> {
  final _controller = Get.put(EditGoalsController());
  @override
  void initState() {
    super.initState();
    _controller.getGoal(widget.model.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: ButtonWidget(
            label: "Save",
            isColored: _controller.isFormFilled.value,
            function: () {
              if (_controller.isFormFilled.value) {
                _controller.saveGoal();
              }
            },
          ),
        );
      }),
      backgroundColor: style.ColorTheme.lightLemonColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            CustomAppbarWidget(title: "Edit financial goal"),
            _textContainer("Title of goal"),
            TextCustomWidget(
              hintText: "Title of goal",
              isAmount: false,
              controller: _controller.titleController,
            ),
            _textContainer("Amount"),
            TextCustomWidget(
              hintText: "Amount (\$)",
              isAmount: true,
              controller: _controller.amountController,
            ),
            // _textContainer("Available amount"),
            // TextCustomWidget(
            //   hintText: "Available amount (\$)",
            //   isAmount: true,
            //   controller: _controller.availableAmountController,
            // ),
            _textContainer("Start date"),
            DateCustomWidget(
              hintText: "00.00.0000",
              onTap: () async {
                await _controller.pickStartDate(context);
              },
              controller: _controller.selectStartDateController,
            ),
            _textContainer("End date"),
            DateCustomWidget(
              hintText: "00.00.0000",
              onTap: () async {
                await _controller.pickEndDate(context);
              },
              controller: _controller.selectEndDateController,
            ),
            _textContainer("Priority"),
            Obx(() => RatingBar(
                  initialRating: _controller.ratings.value,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 30,
                  ratingWidget: RatingWidget(
                    full: Icon(
                      Icons.star,
                      color: style.ColorTheme.lemonColor,
                    ),
                    half: Icon(
                      Icons.star_half,
                      color: style.ColorTheme.lemonColor,
                    ),
                    empty: Icon(
                      Icons.star_border,
                      color: style.ColorTheme.darkGreyColor,
                    ),
                  ),
                  onRatingUpdate: (rating) {
                    _controller.ratings.value = rating;
                  },
                )),
          ],
        ),
      ),
    );
  }

  _textContainer(label) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 15),
      child: Text(
        label,
        style: GoogleFonts.spaceGrotesk(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: style.ColorTheme.blackColor,
        ),
      ),
    );
  }
}
