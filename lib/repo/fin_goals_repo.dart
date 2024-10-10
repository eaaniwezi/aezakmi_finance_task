import 'package:aezakmi_finance_task/models/goals_history_model.dart';
import 'package:hive/hive.dart';
import 'package:aezakmi_finance_task/models/fin_goals_model.dart';

class FinGoalsRepo {
  static const String _boxName = 'fin_goals';

  Future<Box<FinGoalsModel>> _openBox() async {
    var box = await Hive.openBox<FinGoalsModel>(_boxName);
    return box;
  }

  Future<bool> addGoal(FinGoalsModel goal) async {
    try {
      var box = await _openBox();
      await box.add(goal);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<FinGoalsModel?> getGoalById(String goalId) async {
    var box = await _openBox();

    try {
      return box.values.firstWhere((goal) => goal.id == goalId);
    } catch (e) {
      return null;
    }
  }

  // Future<List<FinGoalsModel>> getAllGoals() async {
  //   var box = await _openBox();
  //   return box.values.toList();
  // }
  Future<List<FinGoalsModel>> getAllGoals() async {
    var box = await _openBox();
    var goals = box.values.toList();
    // for (var goal in goals) {
    //   goal.calculatePercentValue();
    //   goal.calculateTotalAmountCollected();
    // }

    return goals;
  }

  Future<bool> updateGoalById(String goalId, FinGoalsModel updatedGoal) async {
    try {
      var box = await _openBox();
      int index = box.values.toList().indexWhere((goal) => goal.id == goalId);
      if (index != -1) {
        await box.putAt(index, updatedGoal);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addGoalToHistory(
      String goalId, GoalsHistoryModel newHistory) async {
    try {
      var box = await _openBox();
      int index = box.values.toList().indexWhere((goal) => goal.id == goalId);

      if (index != -1) {
        FinGoalsModel? goal = box.getAt(index);
        goal!.history?.add(newHistory);
        await box.putAt(index, goal);
        return true;
      }
      return false;
    } catch (e) {
      print("Error adding goal to history: $e");
      return false;
    }
  }

  Future<void> deleteGoalById(String goalId) async {
    var box = await _openBox();
    int index = box.values.toList().indexWhere((goal) => goal.id == goalId);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }

  Future<void> deleteAllGoals() async {
    var box = await _openBox();
    await box.clear();
  }

  Future<int> getGoalsCount() async {
    var box = await _openBox();
    return box.length;
  }
}
