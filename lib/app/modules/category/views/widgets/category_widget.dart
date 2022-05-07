import 'package:e_commerce/app/modules/category/controllers/category_controller.dart';
import 'package:e_commerce/app/modules/category/views/widgets/category_item.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CategoryController>();
    return GetBuilder<CategoryController>(
      builder: (_) {
        if (controller.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Get.isDarkMode ? pinkClr : mainColor,
            ),
          );
        } else {
          return Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    await controller
                        .getCategoryProducts(controller.categoryName[index]);
                    Get.to(() => CategoryItem(
                          title: controller.categoryList[index].category.name,
                        ));
                  },
                  child: Container(
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                        image: NetworkImage(controller.imageCategory[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 20,
                        top: 10,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.bottomStart,
                        child: Text(
                          controller.categoryName[index],
                          style: TextStyle(
                            backgroundColor: Colors.black38,
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 20.h,
                );
              },
              itemCount: controller.categoryName.length,
            ),
          );
        }
      },
    );
  }
}
