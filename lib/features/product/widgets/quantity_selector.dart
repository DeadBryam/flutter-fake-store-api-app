import 'package:cart/features/features.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuantitySelector extends GetWidget<ProductController> {
  const QuantitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: controller.decrement,
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text('${controller.quantity}'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: controller.increment,
          ),
        ],
      ),
    );
  }
}
