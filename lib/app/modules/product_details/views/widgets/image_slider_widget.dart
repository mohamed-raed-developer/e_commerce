import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/app/modules/cart/controllers/cart_controller.dart';
import 'package:e_commerce/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:e_commerce/app/modules/product_details/views/widgets/color_picker_widget.dart';
import 'package:e_commerce/app/routes/app_pages.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSliderWidget extends StatelessWidget {
  ImageSliderWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);
  CarouselController carouselController = CarouselController();
  final String imageUrl;
  final List<Color> colorSelected = [
    kCOlor1,
    kCOlor2,
    kCOlor3,
    kCOlor4,
    kCOlor5,
  ];
  var controller = Get.find<ProductDetailsController>();
  var cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      builder: (_) => Stack(
        children: [
          CarouselSlider.builder(
            itemCount: 3,
            carouselController: carouselController,
            itemBuilder: (context, index, realIndex) {
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(25.r),
                ),
              );
            },
            options: CarouselOptions(
              height: 500.h,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              autoPlayInterval: const Duration(seconds: 2),
              onPageChanged: (index, reson) {
                controller.changePage(index);
              },
            ),
          ),
          Positioned(
            bottom: 30,
            left: 180,
            child: AnimatedSmoothIndicator(
              activeIndex: controller.currentPage,
              count: 3,
              effect: ExpandingDotsEffect(
                dotHeight: 10.h,
                dotWidth: 10.w,
                activeDotColor: Get.isDarkMode ? pinkClr : mainColor,
                dotColor: Colors.black,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: Container(
              height: 200.h,
              width: 50.w,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.changeColor(index);
                      },
                      child: ColorPickerWidget(
                        outerBorder: controller.currentColor == index,
                        color: colorSelected[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 3.h),
                  itemCount: colorSelected.length),
            ),
          ),
          GetBuilder<CartController>(
            builder: (_) => Container(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? pinkClr.withOpacity(0.8)
                            : mainColor.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Get.isDarkMode ? Colors.black : Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Badge(
                    position: BadgePosition.topEnd(top: -10, end: -10),
                    animationDuration: const Duration(milliseconds: 300),
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text(
                      '${cartController.quantity()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.CART);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? pinkClr.withOpacity(0.8)
                              : mainColor.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Get.isDarkMode ? Colors.black : Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
