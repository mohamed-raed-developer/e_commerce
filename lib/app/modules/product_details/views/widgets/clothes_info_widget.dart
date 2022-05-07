import 'package:e_commerce/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:e_commerce/app/modules/welcome/views/widgets/custom_text.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class ClothesInfoWidget extends StatelessWidget {
  ClothesInfoWidget({
    Key? key,
    required this.title,
    required this.id,
    required this.rate,
    required this.description,
  }) : super(key: key);
  final String title;
  final int id;
  final double rate;
  final String description;
  var controller = Get.find<FavoritesController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              GetBuilder<FavoritesController>(
                builder: (_) => Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Colors.white.withOpacity(0.9)
                        : Colors.grey.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      controller.manageFavourites(productId: id);
                    },
                    child: controller.isFavourites(productId: id)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20,
                          )
                        : const Icon(
                            Icons.favorite_outline,
                            color: Colors.black,
                            size: 20,
                          ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              CustomText(
                text: '$rate',
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              SizedBox(
                width: 8.w,
              ),
              RatingBar(
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    size: 10,
                    color: Colors.orangeAccent,
                  ),
                  half: const Icon(
                    Icons.star_half,
                    size: 10,
                    color: Colors.orangeAccent,
                  ),
                  empty: const Icon(
                    Icons.star_border,
                    size: 10,
                    color: Colors.grey,
                  ),
                ),
                onRatingUpdate: (d) {},
                initialRating: rate,
                itemCount: 5,
                itemSize: 20,
                ignoreGestures: true,
                allowHalfRating: true,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          ReadMoreText(
            description,
            trimLines: 3,
            textAlign: TextAlign.justify,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show More'.tr,
            trimExpandedText: 'Show Less'.tr,
            lessStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? pinkClr : mainColor,
            ),
            moreStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? pinkClr : mainColor,
            ),
            style: TextStyle(
              fontSize: 16.sp,
              height: 2,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
