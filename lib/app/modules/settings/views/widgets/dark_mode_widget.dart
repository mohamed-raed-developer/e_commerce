import 'package:e_commerce/app/modules/settings/controllers/settings_controller.dart';
import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/db/storage_helper.dart';

class DarkModeWidget extends StatelessWidget {
  DarkModeWidget({Key? key}) : super(key: key);
  final controller = Get.find<SettingsController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (_) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildIconWidget(),
          Switch(
            value: controller.switchValue,
            activeColor: Get.isDarkMode ? pinkClr : mainColor,
            activeTrackColor: Get.isDarkMode ? pinkClr : mainColor,
            onChanged: (val) {
              Helper().changeTheme();

              controller.switchDark(val);
            },
          ),
        ],
      ),
    );
  }

  Widget buildIconWidget() {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: darkSettings,
            ),
            child: const Icon(
              Icons.dark_mode,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          CustomText(
            text: 'Dark Mode'.tr,
            fontSize: 23.sp,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
