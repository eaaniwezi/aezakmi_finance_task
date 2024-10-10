// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aezakmi_finance_task/models/category_model.dart';
import 'package:aezakmi_finance_task/widgets/button_widget.dart';
import 'package:aezakmi_finance_task/const/color_theme.dart' as style;
import 'package:aezakmi_finance_task/widgets/custom_appbar_widget.dart';
import 'package:aezakmi_finance_task/controllers/add_transaction_controller.dart';

class SelectCategoryScreen extends StatelessWidget {
  final _controller = Get.put(AddTransactionController());
  SelectCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() {
        bool isSelected = _controller.selectedCategoryIndex.value != -1;

        return Padding(
          padding: const EdgeInsets.all(20),
          child: ButtonWidget(
            label: "Save",
            isColored: isSelected,
            function: () {
              _controller.saveTransaction();
            },
          ),
        );
      }),
      backgroundColor: style.ColorTheme.lightLemonColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppbarWidget(title: "Select Category"),
            SizedBox(height: 20),
            Obx(
              () {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _controller.categories.length,
                    itemBuilder: (context, index) {
                      CategoryModel category = _controller.categories[index];

                      if (category.id == 6) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            height: 54,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      color: Color(category.color!),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        category.svgPath.toString(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 14),
                                  Expanded(
                                    child: TextField(
                                      style: GoogleFonts.spaceGrotesk(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: style.ColorTheme.blackColor,
                                      ),
                                      controller: TextEditingController(
                                          text: category.name),
                                      onChanged: (newName) {
                                        _controller.categories[index].name =
                                            newName;
                                      },
                                      decoration: InputDecoration(
                                        hintText: category.name.toString(),
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 10),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Obx(() {
                                    bool isSelected = _controller
                                            .selectedCategoryIndex.value ==
                                        index;

                                    return GestureDetector(
                                      onTap: () {
                                        _controller.selectedCategoryIndex
                                            .value = index;
                                      },
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: isSelected
                                                ? style.ColorTheme.blackColor
                                                : Colors.grey,
                                            width: 2,
                                          ),
                                        ),
                                        child: isSelected
                                            ? Icon(
                                                Icons.check,
                                                size: 16,
                                                color:
                                                    style.ColorTheme.blackColor,
                                              )
                                            : Container(),
                                      ),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            _controller.selectedCategoryIndex.value = index;
                          },
                          child: Container(
                            height: 54,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      color: Color(category.color!),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        category.svgPath.toString(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 14),
                                  Text(
                                    category.name.toString(),
                                    style: GoogleFonts.spaceGrotesk(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: style.ColorTheme.blackColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Obx(() {
                                    bool isSelected = _controller
                                            .selectedCategoryIndex.value ==
                                        index;

                                    return Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: isSelected
                                              ? style.ColorTheme.blackColor
                                              : Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                      child: isSelected
                                          ? Icon(
                                              Icons.check,
                                              size: 16,
                                              color:
                                                  style.ColorTheme.blackColor,
                                            )
                                          : Container(),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
