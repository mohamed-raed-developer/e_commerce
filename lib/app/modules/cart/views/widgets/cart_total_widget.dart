import 'package:e_commerce/app/modules/cart/controllers/cart_controller.dart';
import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class CartTotalWidget extends StatelessWidget {
  CartTotalWidget({
    Key? key,
  }) : super(key: key);
  var controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (_) => Container(
        padding: const EdgeInsets.all(25),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Total'.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                Text(
                  '\$ ${controller.total}',
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: SizedBox(
                height: 60.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    elevation: 0,
                    primary: Get.isDarkMode ? pinkClr : mainColor,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.PAYMENT);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Check Out'.tr,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      const Icon(Icons.shopping_cart),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
