import 'package:e_commerce/app/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CartController extends GetxController {
  List<ProductModel> favoritesList = [];

  var productMap = {};

  void addProductToCart(ProductModel productModel) {
    if (productMap.containsKey(productModel)) {
      productMap[productModel] += 1;
      update();
    } else {
      productMap[productModel] = 1;
      update();
    }
  }

  get productSubTotal =>
      productMap.entries.map((e) => e.key.price * e.value).toList();

  get total => productMap.entries
      .map((e) => e.key.price * e.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);

  void removeProductsFromCart(ProductModel productModel) {
    if (productMap.containsKey(productModel) && productMap[productModel] == 1) {
      productMap.removeWhere((key, value) => key == productModel);
      update();
    } else {
      productMap[productModel] -= 1;
      update();
    }
    Get.snackbar(
      'Error',
      '${productMap[productModel]}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void removeOneProductFromCart(ProductModel productModel) {
    productMap.removeWhere((key, value) => key == productModel);
    update();
  }

  int quantity() {
    if (productMap.isEmpty) {
      return 0;
    } else {
      return productMap.entries
          .map((e) => e.value)
          .toList()
          .reduce((value, element) => value + element);
    }
  }

  void clearAllProducts() {
    productMap.clear();
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
