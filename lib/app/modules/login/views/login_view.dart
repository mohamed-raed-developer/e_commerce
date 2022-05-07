import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../utils/my_string.dart';
import '../../../../utils/theme.dart';
import '../../../routes/app_pages.dart';
import '../../signup/views/widgets/auth_button.dart';
import '../../signup/views/widgets/auth_form_field.dart';
import '../../signup/views/widgets/container_under.dart';
import '../../welcome/views/widgets/custom_text.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.3,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 25,
                    start: 25,
                    top: 40,
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: 'LOG',
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w500,
                              color: Get.isDarkMode ? pinkClr : mainColor,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            CustomText(
                              text: 'IN',
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w500,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        AuthFormField(
                          controller: controller.emailController,
                          hintText: 'Email'.tr,
                          prefixIcon: Get.isDarkMode
                              ? const Icon(
                                  Icons.email,
                                  color: pinkClr,
                                  size: 30,
                                )
                              : Image.asset('assets/images/email.png'),
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
                          height: 20.h,
                        ),
                        GetBuilder<LoginController>(
                          builder: (_) => AuthFormField(
                            controller: controller.passwordController,
                            hintText: 'Password'.tr,
                            isPassword: controller.isVisibility ? false : true,
                            prefixIcon: Get.isDarkMode
                                ? const Icon(
                                    Icons.lock,
                                    color: pinkClr,
                                    size: 30,
                                  )
                                : Image.asset('assets/images/lock.png'),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.visibility();
                              },
                              icon: controller.isVisibility
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: Colors.black,
                                    ),
                            ),
                            typeKeyboard: TextInputType.visiblePassword,
                            validator: (val) {
                              if (val.toString().length < 6) {
                                return 'Password should be longer or equal to 6 char'
                                    .tr;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.FORGET_PASSWORD);
                            },
                            child: CustomText(
                              text: 'Forget Password'.tr,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GetBuilder<LoginController>(
                          builder: (_) => AuthButton(
                            text: 'LOGIN'.tr,
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.loginEmailAndPassword(
                                    email: controller.emailController.text,
                                    password:
                                        controller.passwordController.text);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomText(
                          text: 'OR'.tr,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GetBuilder<LoginController>(
                              builder: (_) => InkWell(
                                onTap: () {
                                  controller.loginWithGoogle();
                                },
                                child: Image.asset('assets/images/google.png'),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            InkWell(
                              onTap: () {
                                controller.loginWithFacebook();
                              },
                              child: Image.asset('assets/images/facebook.png'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ContainerUnder(
                text: 'Don\'t have an Account?'.tr,
                onPressed: () {
                  Get.offNamed(Routes.SIGNUP);
                },
                textBtn: 'SignUp'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
