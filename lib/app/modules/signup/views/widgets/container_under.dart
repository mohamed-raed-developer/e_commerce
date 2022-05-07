import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContainerUnder extends StatelessWidget {
  const ContainerUnder({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.textBtn,
  }) : super(key: key);
  final String text;
  final Function onPressed;
  final String textBtn;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? pinkClr : mainColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: text,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          TextButton(
            onPressed: () => onPressed(),
            child: CustomText(
              text: textBtn,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
