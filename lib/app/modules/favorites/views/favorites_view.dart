import 'package:e_commerce/app/modules/favorites/views/widgets/fav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  @override
  Widget build(BuildContext context) {
    Get.put(FavoritesController());
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: GetBuilder<FavoritesController>(
        builder: (_) {
          if (controller.favouriteList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100.h,
                    width: 100.w,
                    child: Image.asset('assets/images/heart.png'),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Please, Add your favorites products.'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) => FavItemWidget(
                image: controller.favouriteList[index].image,
                title: controller.favouriteList[index].title,
                price: controller.favouriteList[index].price,
                isFavourites: () {
                  controller.manageFavourites(
                      productId: controller.favouriteList[index].id);
                },
              ),
              separatorBuilder: (c, i) => const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              itemCount: controller.favouriteList.length,
            );
          }
        },
      ),
    );
  }
}
