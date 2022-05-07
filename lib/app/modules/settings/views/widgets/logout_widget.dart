import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/theme.dart';
import '../../../login/controllers/login_controller.dart';
import '../../../welcome/views/widgets/custom_text.dart';

class LogoutWidget extends StatelessWidget {
  LogoutWidget({Key? key}) : super(key: key);
  var login = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.defaultDialog(
              title: 'Logout From App',
              titleStyle: TextStyle(
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              middleText: 'Are you sure you need to logout?',
              middleTextStyle: TextStyle(
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.grey,
              radius: 10.r,
              textCancel: 'NO',
              cancelTextColor: Colors.white,
              textConfirm: 'YES',
              confirmTextColor: Colors.white,
              onCancel: () {
                Get.back();
              },
              onConfirm: () {
                login.signOut();
              },
              buttonColor: Get.isDarkMode ? pinkClr : mainColor,
            );
          },
          splashColor: Get.isDarkMode ? Colors.pink : Colors.green[100],
          borderRadius: BorderRadius.circular(12.r),
          customBorder: const StadiumBorder(),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: logOutSettings,
                ),
                child: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              CustomText(
                text: 'Logout'.tr,
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
