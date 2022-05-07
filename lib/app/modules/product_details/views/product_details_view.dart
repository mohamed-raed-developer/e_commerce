import 'package:e_commerce/app/data/models/product_model.dart';
import 'package:e_commerce/app/modules/product_details/views/widgets/add_cart_widget.dart';
import 'package:e_commerce/app/modules/product_details/views/widgets/clothes_info_widget.dart';
import 'package:e_commerce/app/modules/product_details/views/widgets/image_slider_widget.dart';
import 'package:e_commerce/app/modules/product_details/views/widgets/size_list_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageSliderWidget(
                imageUrl: '${Get.arguments['proImage'].image}',
              ),
              ClothesInfoWidget(
                title: '${Get.arguments['proImage'].title}',
                id: Get.arguments['proImage'].id,
                rate: Get.arguments['proImage'].rating.rate,
                description: Get.arguments['proImage'].description,
              ),
              SizeListWidget(),
              AddCartWidget(
                price: Get.arguments['proImage'].price,
                productModel: Get.arguments['proImage'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
