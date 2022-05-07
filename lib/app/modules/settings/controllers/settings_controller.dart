import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/my_string.dart';

class SettingsController extends GetxController {
  // var auth = FirebaseAuth.instance;
  // var googleSignIn = GoogleSignIn();

  var switchValue = false;
  var storage = GetStorage();
  var langLocal = ene;

  void switchDark(val) {
    switchValue = val;
    update();
  }

  String capitalize(String profileName) {
    return profileName.split(' ').map((name) => name.capitalize).join(' ');
  }

  //lang
  void saveLanguage(String lang) async {
    await storage.write('lang', lang);
  }

  Future<String> get getLanguage async {
    return await storage.read('lang');
  }

  void changeLanguage(String typeLang) {
    saveLanguage(typeLang);
    if (langLocal == typeLang) {
      return;
    }
    if (typeLang == frf) {
      langLocal = frf;
      saveLanguage(frf);
    } else if (typeLang == ara) {
      langLocal = ara;
      saveLanguage(ara);
    } else {
      langLocal = ene;
      saveLanguage(ene);
    }
    update();
    // Get.updateLocale(Locale(typeLang));
    // update();
  }

  @override
  void onInit() async {
    super.onInit();
    langLocal = await getLanguage;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
