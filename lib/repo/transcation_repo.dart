import 'package:aezakmi_finance_task/models/transcation_model.dart';
import 'package:hive/hive.dart';

class TranscationRepo {
  static const String boxName = 'transactions';

  Future<Box<TranscationModel>> _getBox() async {
    return await Hive.openBox<TranscationModel>(boxName);
  }

  Future<bool> addTransaction(TranscationModel transaction) async {
    try {
      var box = await _getBox();
      await box.add(transaction);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<TranscationModel>> getTransactions() async {
    var box = await _getBox();
    return box.values.toList();
  }

  Future<TranscationModel?> getTransactionById(String id) async {
    var box = await _getBox();
    try {
      return box.values.firstWhere((transaction) => transaction.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateTransaction(
      String id, TranscationModel updatedTransaction) async {
    var box = await _getBox();
    var index =
        box.values.toList().indexWhere((transaction) => transaction.id == id);

    if (index != -1) {
      await box.putAt(index, updatedTransaction);
    }
  }

  Future<void> deleteTransaction(String id) async {
    var box = await _getBox();
    var index =
        box.values.toList().indexWhere((transaction) => transaction.id == id);

    if (index != -1) {
      await box.deleteAt(index);
    }
  }

  Future<void> deleteAllTransactions() async {
    var box = await _getBox();
    await box.clear();
  }
}
