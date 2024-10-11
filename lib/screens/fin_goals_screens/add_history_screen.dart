import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aezakmi_finance_task/models/fin_goals_model.dart';
import 'package:aezakmi_finance_task/widgets/button_widget.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;
import 'package:aezakmi_finance_task/widgets/custom_appbar_widget.dart';
import 'package:aezakmi_finance_task/widgets/custom_rating_bar_widget.dart';
import 'package:aezakmi_finance_task/controllers/fin_goals_controller.dart';
import 'package:aezakmi_finance_task/controllers/add_history_controller.dart';

class AddHistoryScreen extends StatefulWidget {
  final FinGoalsModel model;
  const AddHistoryScreen({super.key, required this.model});

  @override
  State<AddHistoryScreen> createState() => _AddHistoryScreenState();
}

class _AddHistoryScreenState extends State<AddHistoryScreen> {
  Timer? _timer;
  final addHistoryController = Get.put(AddHistoryController());
  @override
  void initState() {
    super.initState();
    addHistoryController.getGoal(widget.model.id);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      addHistoryController.getGoal(widget.model.id);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    addHistoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _addButton(addHistoryController, context),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: style.ColorTheme.lightLemonColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const CustomAppbarWidget(title: ""),
              _textContainer(widget.model.title),
              _dateText("${widget.model.startDate}-${widget.model.endDate}"),
              const SizedBox(height: 10),
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
                          Obx(() {
                            var fetchedModel =
                                addHistoryController.finGoal.value;
                            if (fetchedModel != null) {
                              return _percentText(
                                "${fetchedModel.percentValue.toString()}%",
                              );
                            } else {
                              return _percentText("%");
                            }
                          }),
                          const SizedBox(height: 10),
                          Obx(() {
                            var fetchedModel =
                                addHistoryController.finGoal.value;
                            if (fetchedModel != null) {
                              return CustomRatingBarWidget(
                                  percentValue:
                                      (fetchedModel.percentValue! / 100)
                                          .clamp(0.0, 1.0));
                            } else {
                              return CustomRatingBarWidget(percentValue: 0.0);
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                  //
                  const SizedBox(width: 10),
                  _emptyContainer(
                      context: context,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textTitleContainer("Collected"),
                            const SizedBox(width: 10),
                            Obx(() {
                              var fetchedModel =
                                  addHistoryController.finGoal.value;
                              if (fetchedModel != null &&
                                  fetchedModel.totalAmountCollected != null) {
                                return _dateText(
                                  "\$ ${fetchedModel.totalAmountCollected.toString()}",
                                );
                              } else {
                                return _dateText("\$ ");
                              }
                            }),
                            const SizedBox(width: 10),
                            _textTitleContainer("Amount"),
                            const SizedBox(width: 10),
                            _dateText(
                              "\$ ${widget.model.amount}",
                            )
                          ],
                        ),
                      ))
                ],
              ),
              const SizedBox(height: 30),
              _textContainer("History"),
              const SizedBox(height: 20),
              Obx(() {
                var fetchedModel = addHistoryController.finGoal.value;
                if (fetchedModel != null && fetchedModel.history != null) {
                  return fetchedModel.history!.isEmpty
                      ? _noHistory()
                      : Column(
                          children: fetchedModel.history!.map((historyModel) {
                            return Container(
                              height: 49,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    _dateText(historyModel.date.toString()),
                                    const Spacer(),
                                    _textContainer(
                                        "+ \$ ${historyModel.amount.toStringAsPrecision(5)}")
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                }
                return _noHistory();
              }),
              const SizedBox(height: 90)
            ],
          ),
        ));
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
      width: size.width * 0.42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  _addButton(AddHistoryController addHistoryController, BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: style.ColorTheme.blackColor,
      child: IconButton(
        icon: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _show(
            context: context,
            addHistoryController: addHistoryController,
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
          child: const CircleAvatar(
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
        const CircleAvatar(
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
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: size.height * 0.28,
            child: Image.asset("assets/pics/wallet.png")),
        _textContainer("No transactions"),
        _tapHereText("Press + to add")
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

  _tapHereText(text) {
    return GestureDetector(
      onTap: () {
        _show(context: context, addHistoryController: addHistoryController);
      },
      child: Text(
        text,
        style: GoogleFonts.spaceGrotesk(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontStyle: FontStyle.normal,
          color: style.ColorTheme.blackColor,
        ),
      ),
    );
  }

  _dateText(text) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
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

  _show(
      {required BuildContext context,
      required AddHistoryController addHistoryController}) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Container(
                decoration: const BoxDecoration(
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
                            addHistoryController.newCollectedAmountController,
                        decoration: InputDecoration(
                          hintText: '0',
                          hintStyle: GoogleFonts.spaceGrotesk(
                            fontWeight: FontWeight.w700,
                            fontSize: 42,
                            fontStyle: FontStyle.normal,
                            color: Colors.grey,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 12, top: 8),
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
                          contentPadding: const EdgeInsets.only(
                              left: 0, top: 12, bottom: 8),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                      const SizedBox(height: 20),
                      ButtonWidget(
                        label: "Save",
                        isColored: true,
                        function: () async {
                          bool isFloat(String value) {
                            if (value.isEmpty) return false;
                            final regex = RegExp(r'^-?\d+(\.\d+)?$');
                            return regex.hasMatch(value);
                          }

                          if (addHistoryController.newCollectedAmountController
                                  .text.isNotEmpty &&
                              isFloat(addHistoryController
                                  .newCollectedAmountController.text)) {
                            var newBalance = double.tryParse(
                                addHistoryController
                                    .newCollectedAmountController.text);

                            if (newBalance != null) {
                              await addHistoryController.addGoals();

                              await addHistoryController
                                  .getGoal(widget.model.id);
                              addHistoryController.finGoal.refresh();
                              addHistoryController.newCollectedAmountController
                                  .clear();
                              Get.find<FinancialGoalsController>()
                                  .getAllFinancialGoals();
                              Navigator.pop(context);
                            } else {
                              Get.snackbar(
                                'Error',
                                'Please enter a valid number.',
                                backgroundColor: style.ColorTheme.redColor,
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
  }
}
