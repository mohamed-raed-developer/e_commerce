import 'package:e_commerce/app/modules/payment/controllers/payment_controller.dart';
import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../login/controllers/login_controller.dart';

class DeliveryContainerWidget extends StatelessWidget {
  DeliveryContainerWidget({Key? key}) : super(key: key);

  final controller = Get.find<PaymentController>();
  final logincontroller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      builder: (_) => Column(
        children: [
          buildRadioContainer(
            address: 'Palestine, Gaza Dair Al Balah',
            name: 'mohamed raed',
            phone: '0598765252',
            title: 'E-Commerce',
            value: 1,
            color:
                controller.changeColors ? Colors.white : Colors.grey.shade300,
            onChange: (int? value) {
              controller.onChangeUser(value);
            },
            icon: Container(),
          ),
          SizedBox(
            height: 10.h,
          ),
          buildRadioContainer(
            address: controller.address,
            name: logincontroller.name,
            phone: controller.phone,
            title: 'Delivery',
            value: 2,
            color:
                controller.changeColors ? Colors.grey.shade300 : Colors.white,
            onChange: (int? value) {
              controller.onChangeUser(value);
              controller.updatePosition();
            },
            icon: InkWell(
              onTap: () {
                Get.defaultDialog(
                  title: 'Enter Your Phone Number'.tr,
                  titleStyle: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Colors.white,
                  radius: 10.r,
                  textCancel: ' Cancel '.tr,
                  cancelTextColor: Colors.black,
                  confirmTextColor: Colors.black,
                  textConfirm: ' Save '.tr,
                  onCancel: () {
                    Get.toNamed(Routes.PAYMENT);
                  },
                  onConfirm: () {
                    Get.back();
                    controller.showPhoneInCard();
                  },
                  buttonColor: Get.isDarkMode ? pinkClr : mainColor,
                  content: Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      onSubmitted: (value) {
                        controller.phoneController.text = value;
                      },
                      controller: controller.phoneController,
                      maxLength: 9,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Get.isDarkMode
                            ? pinkClr.withOpacity(0.1)
                            : mainColor.withOpacity(0.2),
                        focusColor: Colors.red,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Get.isDarkMode ? pinkClr : mainColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.phoneController.clear();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'Enter Your Phone Number'.tr,
                        hintStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.contact_phone,
                size: 20,
                color: Get.isDarkMode ? pinkClr : mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRadioContainer({
    required Color color,
    required int value,
    required Function onChange,
    required String title,
    required String name,
    required String phone,
    required String address,
    required Widget icon,
  }) {
    return Container(
      height: 120.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3.0,
              blurRadius: 5.0,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Radio(
            fillColor: MaterialStateColor.resolveWith((states) => Colors.red),
            value: value,
            groupValue: controller.radioContainerIndex,
            onChanged: (int? value) {
              onChange(value);
            },
          ),
          SizedBox(
            width: 10.w,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomText(
                  text: name,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    const Text('🇵🇸+970 '),
                    CustomText(
                      text: phone,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 120.w,
                    ),
                    SizedBox(
                      child: icon,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomText(
                  text: address,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
