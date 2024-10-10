import 'package:hive/hive.dart';

part 'goals_history_model.g.dart';

@HiveType(typeId: 5)
class GoalsHistoryModel {
  @HiveField(0)
  String date;

  @HiveField(1)
  double amount;

  GoalsHistoryModel({
    required this.date,
    required this.amount,
  });
}
