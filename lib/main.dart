import 'package:device_preview/device_preview.dart';
import 'package:e_commerce/app/data/db/storage_helper.dart';
import 'package:e_commerce/utils/my_string.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/modules/login/controllers/login_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/service/language/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //init local storage
  await GetStorage.init();
  Get.put(LoginController());
  runApp(ScreenUtilInit(
    designSize: const Size(360.0, 712.0),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_) => DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) {
          return GetMaterialApp(
            title: "E-commerce",
            initialRoute: FirebaseAuth.instance.currentUser != null ||
                    GetStorage().read<bool>('auth') == true
                ? Routes.BOTTOM_NAV
                : Routes.WELCOME,
            // AppPages.INITIAL,
            getPages: AppPages.routes,
            // locale: LangTheme().getFromboxLang(),
            // fallbackLocale: Locale('ar', 'Ar'),
            // translations: MessageTransaction(),
            theme: ThemesApp.light,
            darkTheme: ThemesApp.dark,
            themeMode: Helper().themeDataGet,
            debugShowCheckedModeBanner: false,
            locale: Locale(GetStorage().read<String>('lang').toString()),
            fallbackLocale: Locale(ene),
            translations: LocaliztionApp(),

            builder: (context, widget) {
              //add this line
              ScreenUtil.setContext(context);
              return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: DevicePreview.appBuilder(context, widget),
                //child: widget ?? Container(),
              );
            },
          );
        }),
  ));
}
