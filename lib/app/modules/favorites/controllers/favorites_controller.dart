import 'package:e_commerce/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/models/product_model.dart';

class FavoritesController extends GetxController {
  List<ProductModel> favouriteList = [];
  var storage = GetStorage();

  void manageFavourites({required int productId}) async {
    var productList = Get.find<HomeController>().productList;
    var indexRe =
        favouriteList.indexWhere((element) => element.id == productId);
    if (indexRe >= 0) {
      favouriteList.removeAt(indexRe);
      await storage.remove('isFav');
    } else {
      favouriteList
          .add(productList.firstWhere((element) => element.id == productId));
      await storage.write('isFav', favouriteList);
    }

    update();
  }

  bool isFavourites({required int productId}) {
    return favouriteList.any((element) => element.id == productId);
  }

  @override
  void onInit() {
    super.onInit();
    List? storagelist = storage.read<List>('isFav');
    if (storagelist != null) {
      favouriteList = storagelist.map((e) => ProductModel.fromJson(e)).toList();
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
