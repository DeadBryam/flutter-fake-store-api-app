import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart/features/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPresentation extends GetView<ProductController> {
  ProductPresentation({super.key});

  final titleStyle = Get.textTheme.bodyLarge?.copyWith(
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SingleChildScrollView(
          child: controller.isFetching
              ? SizedBox(
                  height: Get.height,
                  child: const Center(child: CircularProgressIndicator()),
                )
              : Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Hero(
                            tag: 'product_image_${controller.product?.id}',
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade100,
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: controller.product?.image ?? '',
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 5,
                          child: SafeArea(
                            child: BackButton(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.product?.title ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color:
                                              Get.theme.colorScheme.secondary,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          controller.product?.rating?.rate
                                                  .toString() ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Get.theme.colorScheme
                                                    .secondary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                '\$${controller.product?.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Get.theme.colorScheme.secondary,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'category'.tr,
                            style: titleStyle,
                          ),
                          Text(
                            controller.product?.category ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'description'.tr,
                            style: titleStyle,
                          ),
                          Text(
                            controller.product?.description ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'quantity'.tr,
                            style: titleStyle,
                          ),
                          const QuantitySelector(),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.maxFinite,
                            child: Obx(
                              () => ElevatedButton(
                                onPressed: controller.isAddingToCart
                                    ? null
                                    : controller.isAddedToCart
                                        ? controller.viewCart
                                        : controller.addToCart,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Get.theme.primaryColor,
                                  disabledBackgroundColor:
                                      Get.theme.primaryColor.withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 15,
                                  ),
                                ),
                                child: Text(
                                  controller.isAddedToCart
                                      ? 'view_cart'.tr
                                      : controller.isAddingToCart
                                          ? 'loading'.tr
                                          : 'add_to_cart'.tr,
                                  style: Get.textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
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
