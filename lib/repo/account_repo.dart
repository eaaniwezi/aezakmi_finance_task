import 'package:aezakmi_finance_task/models/account_model.dart';
import 'package:hive/hive.dart';

class AccountRepo {
  Future<Box<AccountModel>> _openAccountBox() async {
    return await Hive.openBox<AccountModel>('accountBox');
  }

  // Future<double?> getAccountBalance() async {
  //   var box = await _openAccountBox();
  //   var account = box.get('account');
  //   return account?.accountBalance;
  // }
  Future<double?> getAccountBalance() async {
    var box = await _openAccountBox();
    var account = box.get('account');
    double? balance = account?.accountBalance;
    if (balance != null && balance.abs() > 9999) {
      return 0.0;
    }

    return balance;
  }

  Future<void> updateAccountBalance(double newBalance) async {
    var box = await _openAccountBox();
    var account = box.get('account');

    if (account != null) {
      account.accountBalance = newBalance;
      await box.put('account', account);
    } else {
      await box.put('account',
          AccountModel(accountBalance: newBalance, isFirstTimeUser: true));
    }
  }

  Future<bool?> isFirstTimeUser() async {
    var box = await _openAccountBox();
    var account = box.get('account');
    return account?.isFirstTimeUser;
  }

  Future<void> setFirstTimeUserFalse() async {
    var box = await _openAccountBox();
    var account = box.get('account');
    if (account != null) {
      account.isFirstTimeUser = false;
      await box.put('account', account);
    } else {
      await box.put(
          'account', AccountModel(accountBalance: 0, isFirstTimeUser: false));
    }
  }
}
