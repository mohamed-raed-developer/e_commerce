import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../utils/my_string.dart';
import '../../../data/db/dio_helprt.dart';
import '../../../data/models/product_model.dart';

class CategoryController extends GetxController {
  var isLoading = false;
  List<String> categoryName = [];

  List<String> imageCategory = [
    'https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg',
    'https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg',
    'https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg',
    'https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg'
  ];

  getCategorys() async {
    isLoading = true;
    update();
    await BaseClient.get(
      '$baseUrl/products/categories',
      onSuccess: (response) {
        categoryName = List.from(response.data);
      },
    );
    isLoading = false;
    update();
  }

  List<ProductModel> categoryList = [];

  var isLoadingProduct = false;

  getCategoryProducts(String category) async {
    isLoadingProduct = true;
    update();
    try {
      await BaseClient.get(
        '$baseUrl/products/category/$category',
        onSuccess: (response) {
          // Logger().e(response.data);
          for (Map<String, dynamic> i in response.data) {
            categoryList.add(ProductModel.fromJson(i));
            update();
          }
        },
      );
    } catch (e) {
      Logger().e(e.toString());
    }

    isLoadingProduct = false;
    update();
  }

  // getCategoryIndex(int index) async {
  //   var catName = await getCategoryProducts(categoryList[index].category.name);
  //   if (catName != null) {
  //     categoryList.addAll(catName);
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    getCategorys();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
