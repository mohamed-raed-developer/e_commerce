import 'package:e_commerce/app/modules/category/views/widgets/category_widget.dart';
import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    Get.put(CategoryController());
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Padding(
        padding: const EdgeInsetsDirectional.only(start: 15, top: 15),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(top: 15, start: 15),
                child: CustomText(
                  text: 'Category'.tr,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            const CategoryWidget(),
          ],
        ),
      ),
    );
  }
}
