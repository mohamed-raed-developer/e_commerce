import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);
  final String text;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
          primary: Get.isDarkMode ? pinkClr : mainColor,
          minimumSize: const Size(360, 50)),
      child: CustomText(
        text: text,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
