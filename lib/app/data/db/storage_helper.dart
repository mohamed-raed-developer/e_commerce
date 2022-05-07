import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Helper {
  final GetStorage boxStorage = GetStorage();
  final key = 'isDark';
  saveThemeDataInbox(bool isDark) {
    boxStorage.write(key, isDark);
  }

  bool getThemeDataFromBox() {
    return boxStorage.read<bool>(key) ?? false;
  }

  ThemeMode get themeDataGet =>
      getThemeDataFromBox() ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() {
    Get.changeThemeMode(
        getThemeDataFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemeDataInbox(!getThemeDataFromBox());
    // Get.isDarkMode
    //     ? Get.changeThemeMode(ThemeMode.light)
    //     : Get.changeThemeMode(ThemeMode.dark);
  }
}
