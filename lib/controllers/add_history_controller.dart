import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:aezakmi_finance_task/repo/fin_goals_repo.dart';
import 'package:aezakmi_finance_task/models/fin_goals_model.dart';
import 'package:aezakmi_finance_task/models/goals_history_model.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;

class AddHistoryController extends GetxController {
  final finGoalsRepo = FinGoalsRepo();
  // var finGoal = Rxn<FinGoalsModel>();

  Rx<FinGoalsModel?> finGoal = Rx<FinGoalsModel?>(null);

  final newCollectedAmountController = TextEditingController();

  addGoals() async {
    try {
      String formattedDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
      var newBalance = double.tryParse(newCollectedAmountController.text);
      if (newBalance == null) {
        Get.snackbar(
          'Error',
          'Please enter a valid amount.',
          backgroundColor: style.ColorTheme.redColor,
        );
        return;
      }
      var newHistory =
          GoalsHistoryModel(date: formattedDate, amount: newBalance);
      var res = await addGoalToHistory(finGoal.value!.id, newHistory);

      if (res == true) {
        Get.snackbar(
          'Success',
          'Amount added to goal successfully!',
          backgroundColor: style.ColorTheme.lemonColor,
        );
        await Future.delayed(const Duration(seconds: 1));
        var goal = await finGoalsRepo.getGoalById(finGoal.value!.id);
        if (goal != null) {
          finGoal.value = goal;
          await getGoal(finGoal.value!.id);
          finGoal.refresh();
          update();
        }
      } else {
        Get.snackbar(
          'Error',
          'An error occurred while saving the goal.',
          backgroundColor: style.ColorTheme.redColor,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while adding the goal: ${e.toString()}',
        backgroundColor: style.ColorTheme.redColor,
      );
    }
  }

  Future<bool> addGoalToHistory(goalId, newHistory) async {
    return await finGoalsRepo.addGoalToHistory(goalId, newHistory);
  }

  getGoal(goalId) async {
    try {
      var goal = await finGoalsRepo.getGoalById(goalId);
      if (goal != null) {
        finGoal.value = goal;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while fetching the goal: ${e.toString()}',
        backgroundColor: style.ColorTheme.redColor,
      );
    }
  }
}
