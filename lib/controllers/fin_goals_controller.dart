// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:aezakmi_finance_task/repo/fin_goals_repo.dart';
import 'package:aezakmi_finance_task/models/fin_goals_model.dart';

class FinancialGoalsController extends GetxController {
  final finGoalsRepo = FinGoalsRepo();
  var financialGoals = <FinGoalsModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllFinancialGoals();
  }

  Future<void> getAllFinancialGoals() async {
    try {
      List<FinGoalsModel> goals = await finGoalsRepo.getAllGoals();
      financialGoals.value = goals;
    } catch (e) {
      print("Error fetching financial goals: $e");
    }
  }

  Future<void> editFinancialGoal(
      String goalId, FinGoalsModel updatedGoal) async {
    try {
      bool success = await finGoalsRepo.updateGoalById(goalId, updatedGoal);
      if (success) {
        await getAllFinancialGoals();
      } else {
        print("Error updating goal");
      }
    } catch (e) {
      print("Error editing financial goal: $e");
    }
  }
}
