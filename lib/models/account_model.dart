import 'package:hive/hive.dart';

part 'account_model.g.dart';

@HiveType(typeId: 2)
class AccountModel {
  @HiveField(0)
  double accountBalance;

  @HiveField(1)
  bool isFirstTimeUser;

  AccountModel({
    required this.accountBalance,
    this.isFirstTimeUser = true,
  });
}
