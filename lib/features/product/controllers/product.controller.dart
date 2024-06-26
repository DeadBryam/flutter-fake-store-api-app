import 'package:cart/core/core.dart';
import 'package:cart/data/data.dart';
import 'package:cart/routes/routes.dart';
import 'package:cart/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final _id = RxnInt();
  final _product = Rxn<Product>();
  final _isFetching = true.obs;
  final _quantity = 1.obs;

  final _api = Get.find<ApiService>();
  final _cart = Get.find<CartService>();

  int? get id => _id.value;
  Product? get product => _product.value;
  bool get isFetching => _isFetching.value;
  int get quantity => _quantity.value;
  bool get isAddingToCart => _cart.isFetching;
  bool get isAddedToCart => _cart.isProductInCart(product?.id ?? 0);

  Future<void> fetchProduct() async {
    try {
      _isFetching.value = true;
      final res = await _api.getProductById(id!);

      if (res.isOk) {
        final data = ParseUtil.parse<Product>(
          json: res.body,
          fromJson: Product.fromJson,
        );
        _product.value = data;
      }
    } catch (e) {
      Get.close(1);
    } finally {
      _isFetching.value = false;
    }
  }

  Future<void> addToCart() async {
    try {
      await _cart.addToCart(
        product: _product.value,
        quantity: _quantity.value,
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failed_to_add_product_to_cart'.tr,
        backgroundColor: Colors.red,
      );
    }
  }

  void increment() {
    _quantity.value++;
  }

  void decrement() {
    if (_quantity.value > 1) {
      _quantity.value--;
    }
  }

  void viewCart() {
    Get.toNamed<dynamic>(Routes.CART);
  }

  void _onInit() {
    try {
      _id.value = int.tryParse(Get.parameters['id'].toString());
      if (_id.value != null) {
        fetchProduct();
      } else {
        Get.close(1);
      }
    } catch (e) {
      Get.close(1);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _onInit();
  }
}
