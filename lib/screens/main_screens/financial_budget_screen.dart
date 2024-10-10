// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aezakmi_finance_task/widgets/button_widget.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;
import 'package:aezakmi_finance_task/controllers/account_controller.dart';
import 'package:aezakmi_finance_task/widgets/transcation_history_card.dart';

class FinancialBudgetScreen extends StatelessWidget {
  final accountController = Get.put(AccountController());
  FinancialBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: true,
        backgroundColor: style.ColorTheme.lightLemonColor,
        body: Obx(() {
          var savedTransaction = accountController.savedTransactions;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                _header(),
                const SizedBox(height: 15),
                _budgetContainer(context),
                const SizedBox(height: 15),
                _textContainer("Recent activity"),
                const SizedBox(height: 10),
                savedTransaction.isEmpty
                    ? _noHistory(context)
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: savedTransaction.length,
                        itemBuilder: (_, index) {
                          var model = savedTransaction[index];
                          return TransactionHistoryCard(model: model);
                        },
                      ),
              ],
            ),
          );
        }));
  }

  _noHistory(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/pics/wallet.png"),
        _textContainer("No transactions"),
        _dateText("Press + to add", context)
      ],
    );
  }

  _dateText(text, context) {
    return GestureDetector(
      onTap: () {
        _show(context);
      },
      child: Text(
        text,
        style: GoogleFonts.spaceGrotesk(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontStyle: FontStyle.normal,
          color: style.ColorTheme.blackColor,
        ),
      ),
    );
  }

  _budgetContainer(BuildContext context) {
    return Obx(() {
      var balance = accountController.accountBalance.value.toString();
      return Container(
        height: 135,
        decoration: BoxDecoration(
          color: style.ColorTheme.blackColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Balance",
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    color: style.ColorTheme.darkGreyColor,
                  ),
                ),
                Text(
                  "\$ $balance", // Dynamically displaying balance
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.w700,
                    fontSize: 42,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                _show(context);
              },
              child: SvgPicture.asset("assets/icons/edit_balance.svg"),
            ),
          ],
        ),
      );
    });
  }

  _show(context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                  color: style.ColorTheme.blackColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _modalHeader(context),
                      TextField(
                        style: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.w700,
                          fontSize: 42,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        controller: accountController.amountController,
                        decoration: InputDecoration(
                          hintText: '0',
                          hintStyle: GoogleFonts.spaceGrotesk(
                            fontWeight: FontWeight.w700,
                            fontSize: 42,
                            fontStyle: FontStyle.normal,
                            color: Colors.grey,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 12, top: 8),
                            child: Text(
                              '\$',
                              style: GoogleFonts.spaceGrotesk(
                                fontWeight: FontWeight.w700,
                                fontSize: 42,
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(left: 0, top: 12, bottom: 8),
                        ),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
                      const SizedBox(height: 20),
                      ButtonWidget(
                        label: "Save",
                        isColored: true,
                        function: () {
                          bool isFloat(String value) {
                            if (value.isEmpty) return false;
                            final regex = RegExp(r'^-?\d+(\.\d+)?$');
                            return regex.hasMatch(value);
                          }

                          if (accountController
                                  .amountController.text.isNotEmpty &&
                              isFloat(
                                  accountController.amountController.text)) {
                            var newBalance = double.tryParse(
                                accountController.amountController.text);

                            if (newBalance != null) {
                              accountController
                                  .updateAccountBalance(newBalance);
                              accountController.amountController.clear();
                              Navigator.pop(context);
                            } else {
                              Get.snackbar(
                                'Error',
                                'Please enter a valid number.',
                                backgroundColor: style.ColorTheme.redColor,
                              );
                            }
                          } else {
                            Get.snackbar(
                              'Error',
                              'Please enter a valid amount.',
                              backgroundColor: style.ColorTheme.redColor,
                            );
                          }
                        },
                      )
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  _modalHeader(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
          ),
        ),
        Text(
          "Financial budget",
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }

  _textContainer(label) {
    return Text(
      label,
      style: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w700,
        fontSize: 26,
        fontStyle: FontStyle.normal,
        color: style.ColorTheme.blackColor,
      ),
    );
  }

  _header() {
    return Text(
      "\nFinancial\nbudget",
      style: GoogleFonts.spaceGrotesk(
        fontWeight: FontWeight.w700,
        fontSize: 42,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}
