import 'package:cart/core/core.dart';
import 'package:cart/data/dto/dto.dart';
import 'package:cart/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final _cart = <Cart>[].obs;

  final _isFetching = true.obs;

  final _api = Get.find<ApiService>();
  final _auth = Get.find<AuthService>();

  List<Cart> get cart => _cart;
  bool get isFetching => _isFetching.value;

  Future<void> fetchCart() async {
    try {
      _isFetching.value = true;
      final res = await _api.getCartByUserId(_auth.id!);

      if (res.isOk) {
        final cart = List<Cart>.from(
          ParseUtil.parseList(list: res.body, fromJson: Cart.fromJson),
        );

        // This for loop is used to fetch the product details for each product
        // in the cart, cuz the cart only contains the product id and quantity.
        // Is not the best way to do this, but is the only way to get the
        // product, in this test api.
        for (var i = 0; i < cart.length; i++) {
          final cartProducts = List<CartProduct>.from(cart[i].products!);
          for (var j = 0; j < cartProducts.length; j++) {
            final product = await fetchProductById(cartProducts[j].productId!);
            cartProducts[j] = cartProducts[j].copyWith(product: product);
          }
          cart[i] = cart[i].copyWith(products: cartProducts);
        }
        _cart.assignAll(cart);
      } else {
        throw Exception('Failed to fetch cart');
      }
    } catch (e) {
      debugPrint('Error fetching cart: $e');
      Get.snackbar(
        'error'.tr,
        'failed_to_fetch_cart'.tr,
        backgroundColor: Colors.red,
      );
    } finally {
      _isFetching.value = false;
    }
  }

  Future<Product?> fetchProductById(int id) async {
    try {
      final res = await _api.getProductById(id);

      if (res.isOk) {
        return ParseUtil.parse(json: res.body, fromJson: Product.fromJson);
      } else {
        throw Exception('Failed to fetch product');
      }
    } catch (e) {
      debugPrint('Error fetching product: $e');
      Get.snackbar(
        'error'.tr,
        'failed_to_fetch_product'.tr,
        backgroundColor: Colors.red,
      );
    }
    return null;
  }

  Future<void> removeProductFromCart(Cart cart) async {
    try {
      final res = await _api.deleteCartById(cart.id!);

      if (res.isOk) {
        Get.snackbar(
          'success'.tr,
          'product_removed_from_cart'.tr,
          backgroundColor: Colors.green,
        );
        await fetchCart();
      } else {
        throw Exception('Failed to remove product from cart');
      }
    } catch (e) {
      debugPrint('Error removing product from cart: $e');
      Get.snackbar(
        'error'.tr,
        'failed_to_remove_product_from_cart'.tr,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  void onInit() {
    fetchCart();
    super.onInit();
  }
}
