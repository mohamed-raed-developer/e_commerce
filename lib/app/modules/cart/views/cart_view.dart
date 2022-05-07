import 'package:e_commerce/app/modules/cart/views/widgets/cart_product_widget.dart';
import 'package:e_commerce/app/modules/cart/views/widgets/cart_total_widget.dart';
import 'package:e_commerce/app/modules/cart/views/widgets/empty_card_widget.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    return SafeArea(
      child: Scaffold(
          backgroundColor: context.theme.backgroundColor,
          appBar: AppBar(
            title: Text('Cart Item'.tr),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
            actions: [
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Clear Products'.tr,
                    titleStyle: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    middleText: 'Are you sure you need to clear?'.tr,
                    middleTextStyle: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: Colors.grey,
                    radius: 10.r,
                    textCancel: 'NO'.tr,
                    cancelTextColor: Colors.white,
                    textConfirm: 'YES'.tr,
                    confirmTextColor: Colors.white,
                    onCancel: () {
                      Get.toNamed(Routes.CART);
                    },
                    onConfirm: () {
                      controller.clearAllProducts();
                      Get.back();
                    },
                    buttonColor: Get.isDarkMode ? pinkClr : mainColor,
                  );
                },
                icon: const Icon(
                  Icons.backspace,
                ),
              ),
            ],
          ),
          body: GetBuilder<CartController>(
            builder: (_) => controller.productMap.isEmpty
                ? const EmptyCart()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 500.h,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return CartProductWidget(
                                productModel:
                                    controller.productMap.keys.toList()[index],
                                index: index,
                                quantity: controller.productMap.values
                                    .toList()[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 20.h,
                              );
                            },
                            itemCount: controller.productMap.length,
                          ),
                        ),
                        if (controller.productMap.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: CartTotalWidget(),
                          ),
                      ],
                    ),
                  ),
          )),
    );
  }
}
