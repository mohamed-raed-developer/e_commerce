import 'package:e_commerce/app/modules/settings/controllers/settings_controller.dart';
import 'package:e_commerce/utils/my_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/theme.dart';
import '../../../welcome/views/widgets/custom_text.dart';

class LanguageWidget extends StatelessWidget {
  LanguageWidget({Key? key}) : super(key: key);
  final controller = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            color: Colors.transparent,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: languageSettings,
                  ),
                  child: const Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                CustomText(
                  text: 'Language'.tr,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ],
            ),
          ),
          Container(
            width: 120.w,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.r),
                border: Border.all(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  width: 2.w,
                )),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                iconSize: 25,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
                items: [
                  DropdownMenuItem(
                    child: Text(
                      english,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    value: ene,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      arabic,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    value: ara,
                  ),
                  DropdownMenuItem(
                    child: Text(
                      france,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    value: frf,
                  ),
                ],
                value: controller.langLocal,
                onChanged: (val) {
                  controller.changeLanguage(val!);
                  Get.updateLocale(Locale(val));
                  // ene = val!;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
