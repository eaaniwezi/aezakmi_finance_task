import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPageIndex = 0.obs;

  void goToPage(int index) {
    currentPageIndex.value = index;
  }

  bool get isLastPage => currentPageIndex.value == 2;
}
