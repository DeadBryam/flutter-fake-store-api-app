import 'package:cart/features/home/home.dart';
import 'package:cart/shared/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePresentation extends GetView<HomeController> {
  const HomePresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'welcome'.trParams({
                        'name': controller.username,
                      }),
                      style: Get.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'welcome_description'.tr,
                      style: Get.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  onTap: controller.openProfile,
                  child: const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SearchBox(
              onSearch: controller.onSearch,
              controller: controller.searchController,
            ),
            const SizedBox(height: 20),
            Obx(
              () => SizedBox(
                height: 50,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    controller.categories.length,
                    (index) {
                      final category = controller.categories[index];
                      final isSelected =
                          controller.selectedCategory == category;
                      return CategoryItem(
                        category: category,
                        isSelected: isSelected,
                        onTap: controller.selectCategory,
                      );
                    },
                  ),
                ),
              ),
            ),
            Divider(
              height: 40,
              thickness: 2,
              color: Colors.grey.shade200,
            ),
            Obx(
              () => GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                children: List.generate(
                  controller.products.length,
                  (index) {
                    final product = controller.products[index];
                    return ProductCard(
                      product: product,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
