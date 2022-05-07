import 'package:e_commerce/app/modules/payment/views/widgets/dlivery_container_widget.dart';
import 'package:e_commerce/app/modules/payment/views/widgets/payment_method_widget.dart';
import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../utils/theme.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    Get.put(PaymentController(), permanent: true);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        title: Text('Payment'.tr),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Shipping to'.tr,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              SizedBox(
                height: 20.h,
              ),
              DeliveryContainerWidget(),
              SizedBox(
                height: 20.h,
              ),
              CustomText(
                text: 'Payment method'.tr,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              SizedBox(
                height: 20.h,
              ),
              PaymentMethodWidget(),
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: CustomText(
                  text: 'Total: 200\$',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: SizedBox(
                  height: 50.h,
                  width: 150.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                      primary: Get.isDarkMode ? pinkClr : mainColor,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Pay Now'.tr,
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
