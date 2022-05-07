import 'package:e_commerce/app/data/db/dio_helprt.dart';
import 'package:e_commerce/app/data/models/product_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../../../../utils/my_string.dart';

class HomeController extends GetxController {
  List<ProductModel> productList = [];

  var isLoading = false;

  void getProducts() async {
    isLoading = true;
    update();
    await BaseClient.get(
      '$baseUrl/products',
      onSuccess: (response) {
        // Logger().e(response.data);
        for (Map<String, dynamic> i in response.data) {
          productList.add(ProductModel.fromJson(i));
        }
      },
    );
    isLoading = false;
    update();
  }

  List<ProductModel> searchList = [];
  TextEditingController searchTextController = TextEditingController();
  void addToSearchList(String searchName) {
    searchName = searchName.toLowerCase();
    searchList = productList.where((element) {
      var title = element.title.toLowerCase();
      var price = element.price.toString().toLowerCase();
      return title.contains(searchName) || price.contains(searchName);
    }).toList();
    update();
  }

  void clearSearch() {
    searchTextController.clear();
    addToSearchList('');
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchTextController.dispose();
  }
}
