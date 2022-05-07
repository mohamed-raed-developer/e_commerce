import 'package:e_commerce/app/modules/login/controllers/login_controller.dart';
import 'package:e_commerce/app/modules/settings/controllers/settings_controller.dart';
import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileImageWidget extends StatelessWidget {
  ProfileImageWidget({Key? key}) : super(key: key);
  var controller = Get.find<SettingsController>();
  var loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<LoginController>(
          builder: (_) => Row(
            children: [
              Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(loginController.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: controller.capitalize(loginController.name),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  CustomText(
                    text: loginController.email,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
