import 'package:e_commerce/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SizeListWidget extends StatelessWidget {
  SizeListWidget({Key? key}) : super(key: key);
  final List<String> sizeList = ['S', 'M', 'L', 'XL', 'XXL'];
  final controller = Get.find<ProductDetailsController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: GetBuilder<ProductDetailsController>(
        builder: (_) => ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                controller.changeSize(index);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? controller.currentSelected == index
                          ? pinkClr.withOpacity(0.4)
                          : Colors.black
                      : controller.currentSelected == index
                          ? mainColor.withOpacity(0.4)
                          : Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  border:
                      Border.all(color: Colors.grey.withOpacity(0.4), width: 2),
                ),
                child: Text(
                  sizeList[index],
                  style: TextStyle(
                    color: Get.isDarkMode
                        ? controller.currentSelected == index
                            ? Colors.white
                            : Colors.white
                        : controller.currentSelected == index
                            ? Colors.black
                            : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 10.w,
          ),
          itemCount: sizeList.length,
        ),
      ),
    );
  }
}
