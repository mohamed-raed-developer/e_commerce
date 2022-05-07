import 'package:e_commerce/app/data/models/product_model.dart';
import 'package:e_commerce/app/modules/cart/controllers/cart_controller.dart';
import 'package:e_commerce/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:e_commerce/app/modules/home/controllers/home_controller.dart';
import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:e_commerce/app/routes/app_pages.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardItems extends StatelessWidget {
  CardItems({Key? key}) : super(key: key);
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return GetBuilder<HomeController>(builder: (_) {
      if (controller.isLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: Get.isDarkMode ? pinkClr : mainColor,
          ),
        );
      } else {
        return Expanded(
          child: controller.searchList.isEmpty &&
                  controller.searchTextController.text.isNotEmpty
              ? Get.isDarkMode
                  ? Image.asset('assets/images/search_empry_dark.png')
                  : Image.asset('assets/images/search_empry_light.png')
              : GridView.builder(
                  itemCount: controller.searchList.isEmpty
                      ? controller.productList.length
                      : controller.searchList.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 9.0,
                    crossAxisSpacing: 6.0,
                  ),
                  itemBuilder: (context, index) {
                    if (controller.searchList.isEmpty) {
                      return buildCardItems(
                        image: controller.productList[index].image,
                        price: controller.productList[index].price,
                        rate: controller.productList[index].rating.rate,
                        id: controller.productList[index].id,
                        productModel: controller.productList[index],
                        onTap: () {
                          Get.toNamed(Routes.PRODUCT_DETAILS, arguments: {
                            'proImage': (controller.productList[index]),
                          });
                        },
                      );
                    } else {
                      return buildCardItems(
                        image: controller.searchList[index].image,
                        price: controller.searchList[index].price,
                        rate: controller.searchList[index].rating.rate,
                        id: controller.searchList[index].id,
                        productModel: controller.searchList[index],
                        onTap: () {
                          Get.toNamed(Routes.PRODUCT_DETAILS, arguments: {
                            'proImage': (controller.searchList[index]),
                          });
                        },
                      );
                    }
                  },
                ),
        );
      }
    });
  }

  Widget buildCardItems({
    required String image,
    required double price,
    required double rate,
    required int id,
    required ProductModel productModel,
    required Function onTap,
  }) {
    var controller = Get.find<FavoritesController>();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: Get.isDarkMode
                ? [
                    const BoxShadow(
                      color: Colors.white,
                    )
                  ]
                : [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetBuilder<FavoritesController>(
                    builder: (_) => IconButton(
                      onPressed: () {
                        controller.manageFavourites(productId: id);
                      },
                      icon: controller.isFavourites(productId: id)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_outline,
                              color: Colors.black,
                            ),
                    ),
                  ),
                  GetBuilder<CartController>(
                    builder: (_) => IconButton(
                      onPressed: () {
                        cartController.addProductToCart(productModel);
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 110.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(19.r)),
                child: Image.network(
                  image,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ $price',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 20.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.only(start: 3, end: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: '$rate',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            const Icon(
                              Icons.star,
                              size: 13,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
