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
      floatingActionButton: FloatingActionButton(
        onPressed: controller.reloadCart,
        child: const Icon(Icons.refresh),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.cart.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 30,
                      thickness: 1,
                      color: Colors.grey.shade300,
                    ),
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
