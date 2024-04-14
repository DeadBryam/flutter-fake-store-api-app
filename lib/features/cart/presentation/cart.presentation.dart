import 'package:cart/features/features.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPresentation extends GetView<CartController> {
  const CartPresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'.tr),
      ),
      body: Obx(
        () => !controller.isFetching
            ? controller.cart.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          size: 100,
                          color: Get.theme.primaryColor,
                        ),
                        Text(
                          'cart_empty'.tr,
                          style: Get.textTheme.bodyLarge,
                        ),
                        Text(
                          'cart_empty_description'.tr,
                          style: Get.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: controller.cart.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 40),
                    itemBuilder: (context, index) {
                      final cart = controller.cart[index];
                      return CartItem(
                        cart: cart,
                        onRemove: controller.removeProductFromCart,
                      );
                    },
                  )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
