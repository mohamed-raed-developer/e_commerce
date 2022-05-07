import 'package:e_commerce/app/modules/signup/views/widgets/auth_button.dart';
import 'package:e_commerce/app/modules/signup/views/widgets/auth_form_field.dart';
import 'package:e_commerce/app/modules/signup/views/widgets/check_widget.dart';
import 'package:e_commerce/app/modules/signup/views/widgets/container_under.dart';
import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../utils/my_string.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
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
                              text: 'SIGN',
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w500,
                              color: Get.isDarkMode ? pinkClr : mainColor,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            CustomText(
                              text: 'UP',
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
                          controller: controller.nameController,
                          hintText: 'User Name'.tr,
                          prefixIcon: Get.isDarkMode
                              ? const Icon(
                                  Icons.person,
                                  color: pinkClr,
                                  size: 30,
                                )
                              : Image.asset('assets/images/user.png'),
                          suffixIcon: const Text(''),
                          typeKeyboard: TextInputType.text,
                          validator: (val) {
                            if (val.toString().length <= 2 ||
                                !RegExp(validationName).hasMatch(val)) {
                              return 'Enter Valid Name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AuthFormField(
                          controller: controller.emailController,
                          hintText: 'Email',
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
                              return 'Invalid Email';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GetBuilder<SignupController>(
                          builder: (_) => AuthFormField(
                            controller: controller.passwordController,
                            hintText: 'Password',
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
                                return 'Password should be longer or equal to 6 char';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CheckWidget(),
                        SizedBox(
                          height: 30.h,
                        ),
                        GetBuilder<SignupController>(
                          builder: (_) => AuthButton(
                            text: 'SIGN UP'.tr,
                            onPressed: () {
                              if (controller.isCheckBox == false) {
                                Get.snackbar(
                                  'Check Box',
                                  'Please, Accept terms & conditions'.tr,
                                  backgroundColor: Colors.green,
                                );
                              } else if (controller.formKey.currentState!
                                  .validate()) {
                                controller.signupEmailAndPass(
                                    name: controller.nameController.text.trim(),
                                    email:
                                        controller.emailController.text.trim(),
                                    password:
                                        controller.passwordController.text);
                                controller.isCheckBox = true;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ContainerUnder(
                text: 'Already have an Account?'.tr,
                onPressed: () {
                  Get.offNamed(Routes.LOGIN);
                },
                textBtn: 'Login'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
