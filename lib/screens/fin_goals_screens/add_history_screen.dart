// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:aezakmi_finance_task/controllers/edit_goals_controller.dart';
import 'package:aezakmi_finance_task/models/fin_goals_model.dart';
import 'package:aezakmi_finance_task/widgets/button_widget.dart';
import 'package:aezakmi_finance_task/widgets/custom_rating_bar_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;
import 'package:aezakmi_finance_task/widgets/custom_appbar_widget.dart';
import 'package:aezakmi_finance_task/controllers/fin_goals_controller.dart';
import 'package:aezakmi_finance_task/screens/fin_goals_screens/edit_goals_screen.dart';

class AddHistoryScreen extends StatelessWidget {
  final FinGoalsModel model;
  AddHistoryScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditGoalsController());
    return Scaffold(
      floatingActionButton: _addButton(editController, context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: style.ColorTheme.lightLemonColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            CustomAppbarWidget(title: ""),
            _textContainer(model.title),
            _dateText("${model.startDate}-${model.endDate}"),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _emptyContainer(
                  context: context,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _percentText("${model.percentValue.toString()}%"),
                        SizedBox(height: 10),
                        CustomRatingBarWidget(percentValue: 1.0)
                      ],
                    ),
                  ),
                ),
                //
                _emptyContainer(
                    context: context,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _textTitleContainer("Collected"),
                          SizedBox(width: 10),
                          _dateText("\$ 0"),
                          SizedBox(width: 10),
                          _textTitleContainer("Amount"),
                          SizedBox(width: 10),
                          _dateText("\$ ${model.amount}")
                        ],
                      ),
                    ))
              ],
            ),
            _textContainer("History"),
            _noHistory(),
          ],
        ),
      ),
    );
  }

  _textTitleContainer(label) {
    return Text(
      label,
      style: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        fontStyle: FontStyle.normal,
        color: style.ColorTheme.blackColor,
      ),
    );
  }

  _emptyContainer({required Widget child, required BuildContext context}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 116,
      // width: 163,
      width: size.width * 0.45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  _addButton(EditGoalsController editController, BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: style.ColorTheme.blackColor,
      child: IconButton(
        icon: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Container(
                      decoration: BoxDecoration(
                        color: style.ColorTheme.blackColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      height: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            _modalHeader(context),
                            TextField(
                              style: GoogleFonts.spaceGrotesk(
                                fontWeight: FontWeight.w700,
                                fontSize: 42,
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                              ),
                              cursorColor: Colors.white,
                              controller:
                                  editController.newCollectedAmountController,
                              decoration: InputDecoration(
                                hintText: '0',
                                hintStyle: GoogleFonts.spaceGrotesk(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 42,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.grey,
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 12, top: 8),
                                  child: Text(
                                    '\$',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 42,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 0, top: 12, bottom: 8),
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                            ),
                            const SizedBox(height: 20),
                            ButtonWidget(
                              label: "Save",
                              isColored: true,
                              function: () {
                                bool isFloat(String value) {
                                  if (value.isEmpty) return false;
                                  final regex = RegExp(r'^-?\d+(\.\d+)?$');
                                  return regex.hasMatch(value);
                                }

                                if (editController.newCollectedAmountController
                                        .text.isNotEmpty &&
                                    isFloat(editController
                                        .newCollectedAmountController.text)) {
                                  var newBalance = double.tryParse(
                                      editController
                                          .newCollectedAmountController.text);

                                  if (newBalance != null) {
                                    // accountController
                                    //     .updateAccountBalance(newBalance);
                                    // accountController.amountController.clear();
                                    // Navigator.pop(context);
                                  } else {
                                    Get.snackbar(
                                      'Error',
                                      'Please enter a valid number.',
                                      backgroundColor:
                                          style.ColorTheme.redColor,
                                    );
                                  }
                                } else {
                                  Get.snackbar(
                                    'Error',
                                    'Please enter a valid amount.',
                                    backgroundColor: style.ColorTheme.redColor,
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      )),
                ),
              );
            },
          );
        },
      ),
    );
  }

  _modalHeader(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
          ),
        ),
        Text(
          "Add amount",
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }

  _noHistory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/pics/wallet.png"),
        _textContainer("No transactions"),
        _dateText("Press + to add")
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
        color: style.ColorTheme.blackColor,
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
}
