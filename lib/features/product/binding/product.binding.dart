import 'package:cart/features/product/product.dart';
import 'package:get/get.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(ProductController.new);
  }
}
