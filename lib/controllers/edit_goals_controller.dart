// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:aezakmi_finance_task/repo/fin_goals_repo.dart';
import 'package:aezakmi_finance_task/models/fin_goals_model.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;
import 'package:aezakmi_finance_task/screens/main_screens/main_screen.dart';
import 'package:aezakmi_finance_task/controllers/fin_goals_controller.dart';

class EditGoalsController extends GetxController {
  final finGoalsRepo = FinGoalsRepo();
  var finGoal = Rxn<FinGoalsModel>();

  var isFormFilled = false.obs;

  RxDouble ratings = 0.0.obs;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  // final TextEditingController availableAmountController =
  //     TextEditingController();
  final TextEditingController selectStartDateController =
      TextEditingController();
  final TextEditingController selectEndDateController = TextEditingController();

  final TextEditingController newCollectedAmountController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // ratings.value = finGoal.value!.priority;
    // titleController.text = finGoal.value!.title;
    // amountController.text = finGoal.value!.amount.toString();
    // availableAmountController.text = finGoal.value!.availableAmount.toString();
    // selectStartDateController.text = finGoal.value!.startDate;
    // selectEndDateController.text = finGoal.value!.endDate;
    titleController.addListener(_checkFormFilled);
    amountController.addListener(_checkFormFilled);
    selectStartDateController.addListener(_checkFormFilled);
    selectEndDateController.addListener(_checkFormFilled);
  }

  void clearForm() {
    ratings.value = 0.0;
    titleController.clear();
    amountController.clear();
    // availableAmountController.clear();
    selectStartDateController.clear();
    selectEndDateController.clear();
    isFormFilled.value = false;
  }

  void _checkFormFilled() {
    isFormFilled.value = titleController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        // availableAmountController.text.isNotEmpty &&
        selectStartDateController.text.isNotEmpty &&
        selectEndDateController.text.isNotEmpty;
  }

  bool isFloat(String value) {
    if (value.isEmpty) return false;
    final regex = RegExp(r'^-?\d+(\.\d+)?$');
    return regex.hasMatch(value);
  }

  void saveGoal() async {
    try {
      if (isFormFilled.value &&
          isFloat(amountController.text) &&
          // isFloat(availableAmountController.text) &&
          ratings.value > 0.0) {
        DateTime startDate =
            DateFormat('dd.MM.yyyy').parse(selectStartDateController.text);
        DateTime endDate =
            DateFormat('dd.MM.yyyy').parse(selectEndDateController.text);
        if (startDate.isAfter(endDate)) {
          Get.snackbar(
            'Error',
            'Start date cannot be after end date!',
            backgroundColor: style.ColorTheme.redColor,
          );
          return;
        }
        var uuid = Uuid();
        String goalId = uuid.v4();
        double amount = double.tryParse(amountController.text) ?? 0.0;
        // double availableAmount =
        //     double.tryParse(availableAmountController.text) ?? 0.0;
        var goalModel = FinGoalsModel(
          id: goalId,
          title: titleController.text,
          amount: amount,
          // availableAmount: availableAmount,
          startDate: selectStartDateController.text,
          endDate: selectEndDateController.text,
          priority: ratings.value,
        );
        var res = await updateGoals(finGoal.value!.id, goalModel);

        if (res == true) {
          Get.snackbar(
            'Success',
            'Goal saved successfully!',
            backgroundColor: style.ColorTheme.lemonColor,
          );
          clearForm();
          Get.find<FinancialGoalsController>().getAllFinancialGoals();
          Get.to(() => MainScreen());
        }
      } else {
        Get.snackbar(
          'Error',
          'Check all fields!',
          backgroundColor: style.ColorTheme.redColor,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while saving the goal: ${e.toString()}',
        backgroundColor: style.ColorTheme.redColor,
      );
    }
  }

  Future<bool> updateGoals(goalId, updatedGoal) async {
    return await finGoalsRepo.updateGoalById(goalId, updatedGoal);
  }

  getGoal(goalId) async {
    try {
      var goal = await finGoalsRepo.getGoalById(goalId);
      if (goal != null) {
        finGoal.value = goal;

        ratings.value = finGoal.value!.priority;
        titleController.text = finGoal.value!.title;
        amountController.text = finGoal.value!.amount.toString();
        // availableAmountController.text =
        //     finGoal.value!.availableAmount.toString();
        selectStartDateController.text = finGoal.value!.startDate;
        selectEndDateController.text = finGoal.value!.endDate;
      }
    } catch (e) {}
  }

  Future<void> pickStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd.MM.yyyy').format(pickedDate);
      selectStartDateController.text = formattedDate;
    }
  }

  Future<void> pickEndDate(BuildContext context) async {
    DateTime initialStartDate = selectStartDateController.text.isNotEmpty
        ? DateFormat('dd.MM.yyyy').parse(selectStartDateController.text)
        : DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialStartDate,
      firstDate: initialStartDate,
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd.MM.yyyy').format(pickedDate);
      selectEndDateController.text = formattedDate;
    }
  }
}
