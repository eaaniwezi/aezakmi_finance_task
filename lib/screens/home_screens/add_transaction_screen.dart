// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aezakmi_finance_task/widgets/button_widget.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;
import 'package:aezakmi_finance_task/widgets/text_custom_widget.dart';
import 'package:aezakmi_finance_task/widgets/custom_appbar_widget.dart';
import 'package:aezakmi_finance_task/screens/select_category_screen.dart';
import 'package:aezakmi_finance_task/controllers/add_transaction_controller.dart';

class AddTransactionScreen extends StatelessWidget {
  final _controller = Get.put(AddTransactionController());
  AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: ButtonWidget(
            label: "Next",
            isColored: _controller.isFormFilled.value,
            function: () {
              if (_controller.isFormFilled.value) {
                Get.to(() => SelectCategoryScreen());
              }
            },
          ),
        );
      }),
      backgroundColor: style.ColorTheme.lightLemonColor,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() {
            bool isCost = _controller.selectedIndex.value == 0;
            return ListView(
              children: [
                CustomAppbarWidget(title: "Add transaction"),
                _headerWidget(),
                _textContainer(isCost ? "Title of cost" : "Title of income"),
                TextCustomWidget(
                  hintText: isCost ? "Title of cost" : "Title of income",
                  isAmount: false,
                  controller: _controller.titleController,
                ),
                _textContainer("Amount"),
                TextCustomWidget(
                  hintText: "Amount (\$)",
                  isAmount: true,
                  controller: _controller.amountController,
                ),
                _textContainer("Date"),
                DateCustomWidget(
                  hintText: "00.00.0000",
                  onTap: () async {
                    await _controller.pickDate(context);
                  },
                  controller: _controller.selectDateController,
                )
              ],
            );
          })),
    );
  }

  _headerWidget() {
    return Container(
      height: 34,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: style.ColorTheme.blackColor,
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildHeaderItem(
              iconPath: "assets/pics/costs.png",
              index: 0,
            ),
            _buildHeaderItem(
              iconPath: "assets/pics/income.png",
              index: 1,
            ),
          ],
        ),
      ),
    );
  }

  _buildHeaderItem({required String iconPath, required int index}) {
    final bool isSelected = _controller.selectedIndex.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _controller.changePage(index),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(
            iconPath,
            color: isSelected ? style.ColorTheme.blackColor : Colors.white,
          ),
        ),
      ),
    );
  }

  _textContainer(label) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 15),
      child: Text(
        label,
        style: GoogleFonts.spaceGrotesk(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: style.ColorTheme.blackColor,
        ),
      ),
    );
  }
}
