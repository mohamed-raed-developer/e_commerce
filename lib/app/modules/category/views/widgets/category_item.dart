import 'package:e_commerce/app/data/models/product_model.dart';
import 'package:e_commerce/app/modules/cart/controllers/cart_controller.dart';
import 'package:e_commerce/app/modules/category/controllers/category_controller.dart';
import 'package:e_commerce/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:e_commerce/app/modules/home/controllers/home_controller.dart';
import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:e_commerce/app/routes/app_pages.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({Key? key, required this.title}) : super(key: key);
  final cartController = Get.find<CartController>();
  final String title;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var categoryController = Get.find<CategoryController>();
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Get.isDarkMode ? darkGreyClr : mainColor,
      ),
      body: GetBuilder<HomeController>(builder: (_) {
        if (controller.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Get.isDarkMode ? pinkClr : mainColor,
            ),
          );
        } else {
          return GetBuilder<CategoryController>(
            builder: (_) {
              if (categoryController.isLoadingProduct) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Get.isDarkMode ? pinkClr : mainColor,
                  ),
                );
              } else {
                return GridView.builder(
                  itemCount: categoryController.categoryList.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 9.0,
                    crossAxisSpacing: 6.0,
                  ),
                  itemBuilder: (context, index) {
                    return buildCategoryItem(
                      image: categoryController.categoryList[index].image,
                      price: categoryController.categoryList[index].price,
                      rate: categoryController.categoryList[index].rating.rate,
                      id: categoryController.categoryList[index].id,
                      productModel: categoryController.categoryList[index],
                      onTap: () {
                        Get.toNamed(Routes.PRODUCT_DETAILS, arguments: {
                          'proImage': (categoryController.categoryList[index]),
                        });
                      },
                    );
                  },
                );
              }
            },
          );
        }
      }),
    );
  }

  Widget buildCategoryItem({
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
