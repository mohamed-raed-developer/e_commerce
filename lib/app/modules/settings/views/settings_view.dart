import 'package:e_commerce/app/data/db/storage_helper.dart';
import 'package:e_commerce/app/modules/settings/views/widgets/dark_mode_widget.dart';
import 'package:e_commerce/app/modules/settings/views/widgets/logout_widget.dart';
import 'package:e_commerce/app/modules/settings/views/widgets/profile_image_widget.dart';
import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';
import 'widgets/language_widget.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ProfileImageWidget(),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            color: Get.isDarkMode ? Colors.white : Colors.grey,
            thickness: 2,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomText(
            text: 'GENERAL'.tr,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? pinkClr : mainColor,
          ),
          SizedBox(
            height: 20.h,
          ),
          DarkModeWidget(),
          SizedBox(
            height: 20.h,
          ),
          LanguageWidget(),
          SizedBox(
            height: 20.h,
          ),
          LogoutWidget(),
        ],
      ),
    );
  }
}
