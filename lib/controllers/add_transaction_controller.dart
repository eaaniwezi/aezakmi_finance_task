// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:aezakmi_finance_task/models/category_model.dart';
import 'package:aezakmi_finance_task/repo/transcation_repo.dart';
import 'package:aezakmi_finance_task/models/transcation_model.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;
import 'package:aezakmi_finance_task/controllers/account_controller.dart';
import 'package:aezakmi_finance_task/screens/main_screens/main_screen.dart';

class AddTransactionController extends GetxController {
  final transcationRepo = TranscationRepo();

  var selectedIndex = 0.obs;
  var isFormFilled = false.obs;
  var selectedCategoryIndex = RxInt(-1);
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController selectDateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    titleController.addListener(_checkFormFilled);
    amountController.addListener(_checkFormFilled);
    selectDateController.addListener(_checkFormFilled);
    updateCategories();
    selectedIndex.listen((index) {
      updateCategories();
    });
  }

  void updateCategories() {
    if (selectedIndex.value == 0) {
      categories.value = costCategories;
    } else {
      categories.value = incomeCategories;
    }
  }

  void clearForm() {
    titleController.clear();
    amountController.clear();
    selectDateController.clear();
    selectedCategoryIndex.value = -1;
    selectedIndex.value = 0;
    isFormFilled.value = false;
    updateCategories();
  }

  void _checkFormFilled() {
    isFormFilled.value = titleController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        selectDateController.text.isNotEmpty;
  }

  void changePage(int index) {
    selectedIndex.value = index;
  }

  void saveTransaction() async {
    try {
      bool isFloat(String value) {
        if (value.isEmpty) return false;
        final regex = RegExp(r'^-?\d+(\.\d+)?$');
        return regex.hasMatch(value);
      }

      var selectedCategory = categories[selectedCategoryIndex.value];

      if (selectedCategory.name.toString().isNotEmpty &&
          isFormFilled.value &&
          isFloat(amountController.text)) {
        var uuid = Uuid();
        String transactionId = uuid.v4();
        var isCost = selectedIndex.value == 0 ? true : false;
        double amount = double.tryParse(amountController.text) ?? 0.0;

        if (isCost) {
          amount = -amount;
        }

        var transaction = TranscationModel(
          id: transactionId,
          title: titleController.text,
          amount: amount,
          timing: selectDateController.text,
          isCost: isCost,
          selectedCategory: selectedCategory,
        );

        var res = await addTransaction(transaction);
        if (res == true) {
          Get.snackbar(
            'Success',
            'Transaction saved successfully!',
            backgroundColor: style.ColorTheme.lemonColor,
          );

          clearForm();
          Get.to(() => MainScreen());
          Get.find<AccountController>().getActualBalance();
          Get.find<AccountController>().loadAccountData();
        } else {
          Get.snackbar(
            'Error',
            'An error occurred while saving the transaction:',
            backgroundColor: style.ColorTheme.redColor,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Please fill in all fields and select a category first.',
          backgroundColor: style.ColorTheme.redColor,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while saving the transaction: ${e.toString()}',
        backgroundColor: style.ColorTheme.redColor,
      );
    }
  }

  Future<bool> addTransaction(TranscationModel transaction) async {
    return await transcationRepo.addTransaction(transaction);
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd.MM.yyyy').format(pickedDate);
      selectDateController.text = formattedDate;
    }
  }

  List<CategoryModel> costCategories = [
    CategoryModel(
      id: 1,
      name: "Shopping",
      svgPath: "assets/icons/shopping-cart.svg",
      color: 0xFFE54D2E,
    ),
    CategoryModel(
      id: 2,
      name: "Housing and utilities",
      svgPath: "assets/icons/house.svg",
      color: 0xFF0091FF,
    ),
    CategoryModel(
      id: 3,
      name: "Transportation",
      svgPath: "assets/icons/bus.svg",
      color: 0xFFFFB224,
    ),
    CategoryModel(
      id: 4,
      name: "Health and personal care",
      svgPath: "assets/icons/healtcare.svg",
      color: 0xFFE93D82,
    ),
    CategoryModel(
      id: 5,
      name: "Entertainment and leisure",
      svgPath: "assets/icons/game-controller.svg",
      color: 0xFF46A758,
    ),
    CategoryModel(
      id: 6,
      name: "Another...",
      svgPath: "assets/icons/credit-card-pos.svg",
      color: 0xFF8E4EC6,
    ),
  ].obs;

  List<CategoryModel> incomeCategories = [
    CategoryModel(
      id: 1,
      name: "Basic income",
      svgPath: "assets/icons/wallet.svg",
      color: 0xFFE54D2E,
    ),
    CategoryModel(
      id: 2,
      name: "Passive income",
      svgPath: "assets/icons/money-send-circle.svg",
      color: 0xFF0091FF,
    ),
    CategoryModel(
      id: 3,
      name: "Additional income",
      svgPath: "assets/icons/save-money-dollar.svg",
      color: 0xFFFFB224,
    ),
    CategoryModel(
      id: 4,
      name: "Social benefits",
      svgPath: "assets/icons/bank.svg",
      color: 0xFFE93D82,
    ),
    CategoryModel(
      id: 5,
      name: "Refund",
      svgPath: "assets/icons/money-add.svg",
      color: 0xFF46A758,
    ),
    CategoryModel(
      id: 6,
      name: "Another...",
      svgPath: "assets/icons/credit-card-pos.svg",
      color: 0xFF8E4EC6,
    ),
  ].obs;
}
