import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 3)
class CategoryModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? svgPath;

  @HiveField(3)
  int? color;

  CategoryModel({
    required this.id,
    required this.name,
    required this.svgPath,
    required this.color,
  });
}
