import 'package:aezakmi_finance_task/models/transcation_model.dart';
import 'package:aezakmi_finance_task/repo/account_repo.dart';
import 'package:aezakmi_finance_task/repo/transcation_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  final AccountRepo _accountRepo = AccountRepo();
  final TranscationRepo _transcationRepo = TranscationRepo();

  RxDouble accountBalance = 0.0.obs;
  RxBool isFirstTimeUser = true.obs;
  RxList<TranscationModel> savedTransactions = <TranscationModel>[].obs;
  final TextEditingController amountController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadAccountData();
    getActualBalance();
  }

  Future<void> loadAccountData() async {
    accountBalance.value = await getActualBalance();
    isFirstTimeUser.value = await _accountRepo.isFirstTimeUser() ?? true;
  }

  Future<double?> getAccountBalance() async {
    var acc = await getActualBalance();
    return acc;
  }

  Future<void> updateAccountBalance(double newBalance) async {
    accountBalance.value = newBalance;
    await _accountRepo.updateAccountBalance(newBalance);
    await loadAccountData();
  }

  Future<bool?> isFirstTimeUserFlag() async {
    return isFirstTimeUser.value;
  }

  Future<void> setFirstTimeUserFalse() async {
    isFirstTimeUser.value = false;
    await _accountRepo.setFirstTimeUserFalse();
  }

  Future<double> getActualBalance() async {
    try {
      var transactions = await _transcationRepo.getTransactions();
      savedTransactions.value = transactions;
      double savedAccountBalance =
          await _accountRepo.getAccountBalance() ?? 0.0;
      double totalTransactionAmount = 0.0;
      for (var transaction in transactions) {
        totalTransactionAmount += transaction.amount;
      }
      double actualBalance = savedAccountBalance + totalTransactionAmount;
      return actualBalance;
    } catch (e) {
      return 0.0;
    }
  }
}
