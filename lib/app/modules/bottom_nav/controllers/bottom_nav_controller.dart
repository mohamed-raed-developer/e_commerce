import 'package:e_commerce/app/modules/category/views/category_view.dart';
import 'package:e_commerce/app/modules/favorites/views/favorites_view.dart';
import 'package:e_commerce/app/modules/home/views/home_view.dart';
import 'package:e_commerce/app/modules/settings/views/settings_view.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;

  final tabs = [
    HomeView(),
    CategoryView(),
    FavoritesView(),
    SettingsView(),
  ].obs;

  final titles = [
    'E-commerce',
    'Categories'.tr,
    'Favorites'.tr,
    'Settings'.tr,
  ].obs;

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
