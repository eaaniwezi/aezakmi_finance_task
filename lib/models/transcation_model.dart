import 'package:aezakmi_finance_task/models/category_model.dart';
import 'package:hive/hive.dart';

part 'transcation_model.g.dart';

@HiveType(typeId: 1)
class TranscationModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String timing;

  @HiveField(4)
  bool isCost;

  @HiveField(5)
  CategoryModel selectedCategory;

  TranscationModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.timing,
    required this.isCost,
    required this.selectedCategory,
  });
}
