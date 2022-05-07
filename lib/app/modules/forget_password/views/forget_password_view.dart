import 'package:e_commerce/app/modules/signup/views/widgets/auth_button.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../utils/my_string.dart';
import '../../signup/views/widgets/auth_form_field.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Forget Password'.tr,
            style: TextStyle(color: Get.isDarkMode ? pinkClr : mainColor),
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        body: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'If you want to recover your account, then please provide your email ID delow...'
                        .tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Image.asset(
                    'assets/images/forgetpass copy.png',
                    width: 250.w,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  AuthFormField(
                    controller: controller.emailController,
                    hintText: 'Email'.tr,
                    prefixIcon: Get.isDarkMode
                        ? Image.asset('assets/images/email.png')
                        : const Icon(
                            Icons.email,
                            color: pinkClr,
                            size: 30,
                          ),
                    suffixIcon: const Text(''),
                    typeKeyboard: TextInputType.emailAddress,
                    validator: (val) {
                      if (!RegExp(validationEmail).hasMatch(val)) {
                        return 'Invalid Email'.tr;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  GetBuilder<ForgetPasswordController>(
                    builder: (_) => AuthButton(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.resetPassword(
                              email: controller.emailController.text.trim());
                        }
                      },
                      text: 'SEND'.tr,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
