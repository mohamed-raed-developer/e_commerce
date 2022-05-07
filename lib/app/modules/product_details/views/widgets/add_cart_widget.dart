import 'package:e_commerce/app/data/models/product_model.dart';
import 'package:e_commerce/app/modules/cart/controllers/cart_controller.dart';
import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddCartWidget extends StatelessWidget {
  AddCartWidget({
    Key? key,
    required this.price,
    required this.productModel,
  }) : super(key: key);
  final double price;
  final ProductModel productModel;
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Price'.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              Text(
                '\$$price',
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
                  cartController.addProductToCart(productModel);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add to Cart'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    const Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
