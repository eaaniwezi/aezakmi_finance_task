import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:aezakmi_finance_task/models/account_model.dart';
import 'package:aezakmi_finance_task/models/category_model.dart';
import 'package:aezakmi_finance_task/models/fin_goals_model.dart';
import 'package:aezakmi_finance_task/models/transcation_model.dart';
import 'package:aezakmi_finance_task/models/goals_history_model.dart';
import 'package:aezakmi_finance_task/controllers/account_controller.dart';
import 'package:aezakmi_finance_task/screens/intro_screens/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  Get.put(AccountController());

  // Registering the adapters
  Hive.registerAdapter(TranscationModelAdapter());
  Hive.registerAdapter(AccountModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(FinGoalsModelAdapter());
  Hive.registerAdapter(GoalsHistoryModelAdapter());

  // Opening all the necessary boxes
  await Hive.openBox<FinGoalsModel>('fin_goals');
  await Hive.openBox<TranscationModel>('transactions');
  await Hive.openBox<AccountModel>('account');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Finance Task',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// flutter build apk --split-per-abi
