import 'package:e_commerce/app/modules/payment/controllers/payment_controller.dart';
import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentMethodWidget extends StatelessWidget {
  PaymentMethodWidget({Key? key}) : super(key: key);
  final controller = Get.find<PaymentController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GetBuilder<PaymentController>(
        builder: (_) => Column(
          children: [
            buildRadioPayment(
                name: 'PayPal',
                image: 'assets/images/paypal.png',
                scale: 0.7,
                value: 1,
                onChange: (int? value) {
                  controller.onChangePayment(value);
                }),
            SizedBox(
              height: 10.h,
            ),
            buildRadioPayment(
                name: 'Google Pay',
                image: 'assets/images/google.png',
                scale: 0.8,
                value: 2,
                onChange: (int? value) {
                  controller.onChangePayment(value);
                }),
            SizedBox(
              height: 10.h,
            ),
            buildRadioPayment(
                name: 'Credit Card',
                image: 'assets/images/credit.png',
                scale: 0.7,
                value: 3,
                onChange: (int? value) {
                  controller.onChangePayment(value);
                }),
          ],
        ),
      ),
    );
  }

  Widget buildRadioPayment({
    required String image,
    required double scale,
    required String name,
    required int value,
    required Function onChange,
  }) {
    return Container(
      height: 50.h,
      width: double.infinity,
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                image,
                scale: scale,
              ),
              SizedBox(
                width: 10.w,
              ),
              CustomText(
                text: name,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ],
          ),
          Radio(
            value: value,
            groupValue: controller.radioPaymentIndex,
            fillColor: MaterialStateColor.resolveWith((states) => mainColor),
            onChanged: (int? value) {
              onChange(value);
            },
          ),
        ],
      ),
    );
  }
}
