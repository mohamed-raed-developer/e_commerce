import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  int currentPage = 0;
  void changePage(int index) {
    currentPage = index;
    update();
  }

  int currentColor = 0;
  void changeColor(int index) {
    currentColor = index;
    update();
  }

  var currentSelected = 0;
  void changeSize(int index) {
    currentSelected = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
