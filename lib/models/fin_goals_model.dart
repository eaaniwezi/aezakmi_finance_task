import 'package:aezakmi_finance_task/models/goals_history_model.dart';
import 'package:hive/hive.dart';

part 'fin_goals_model.g.dart';

@HiveType(typeId: 4)
class FinGoalsModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String startDate;

  @HiveField(4)
  String endDate;

  @HiveField(5)
  double priority;

  @HiveField(6)
  List<GoalsHistoryModel>? history;

  @HiveField(7)
  double? percentValue;

  @HiveField(8)
  double? totalAmountCollected;

  FinGoalsModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.priority,
    this.history,
    this.percentValue,
    this.totalAmountCollected,
  });

  void calculatePercentValue() {
    if (history == null || history!.isEmpty) {
      percentValue = 0.0;
    } else {
      double totalHistoryAmount = 0.0;
      for (var historyItem in history!) {
        totalHistoryAmount += historyItem.amount;
      }
      percentValue = (totalHistoryAmount / amount) * 100;
    }

    if (percentValue != null) {
      percentValue = percentValue!.clamp(0.0, 100.0);
      percentValue = double.parse(percentValue!.toStringAsFixed(2));
    }
  }

  void calculateTotalAmountCollected() {
    if (history == null || history!.isEmpty) {
      totalAmountCollected = 0.0;
    } else {
      double totalHistoryAmount = 0.0;
      for (var historyItem in history!) {
        totalHistoryAmount += historyItem.amount;
      }
      totalAmountCollected = totalHistoryAmount;
    }
    if (totalAmountCollected != null) {
      totalAmountCollected =
          double.parse(totalAmountCollected!.toStringAsFixed(2));
    }
  }
}
