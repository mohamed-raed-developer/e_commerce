import 'package:e_commerce/app/data/models/product_model.dart';
import 'package:e_commerce/app/modules/cart/controllers/cart_controller.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartProductWidget extends StatelessWidget {
  CartProductWidget({
    Key? key,
    required this.productModel,
    required this.index,
    required this.quantity,
  }) : super(key: key);
  final ProductModel productModel;
  final int index;
  final int quantity;
  var controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (_) => Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
        height: 130.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? pinkClr.withOpacity(0.7)
              : mainColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 120.h,
              width: 100.w,
              margin: const EdgeInsetsDirectional.only(start: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                  image: NetworkImage(productModel.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              flex: 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.title,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    '\$ ${controller.productSubTotal[index].toStringAsFixed(2)}',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.removeProductsFromCart(productModel);
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      '$quantity',
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.addProductToCart(productModel);
                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    controller.removeOneProductFromCart(productModel);
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 20,
                    color: Get.isDarkMode ? Colors.black : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
