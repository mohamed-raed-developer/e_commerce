import 'package:e_commerce/app/modules/signup/controllers/signup_controller.dart';
import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckWidget extends StatelessWidget {
  CheckWidget({Key? key}) : super(key: key);
  final controller = Get.find<SignupController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
      builder: (_) => Row(
        children: [
          InkWell(
            onTap: () {
              controller.checkBox();
            },
            child: Container(
              height: 35.h,
              width: 35.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: controller.isCheckBox
                  ? Get.isDarkMode
                      ? const Icon(
                          Icons.done,
                          color: pinkClr,
                        )
                      : Image.asset('assets/images/check.png')
                  : Container(),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Row(
            children: [
              CustomText(
                text: 'I accept '.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              CustomText(
                text: 'terms & conditions'.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                color: Get.isDarkMode ? Colors.white : Colors.black,
                textDecoration: TextDecoration.underline,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
