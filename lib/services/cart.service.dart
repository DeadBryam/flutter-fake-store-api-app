import 'package:cart/core/core.dart';
import 'package:cart/data/dto/dto.dart';
import 'package:cart/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartService extends GetxService {
  final _cart = <Cart>[].obs;
  final _isFetching = false.obs;

  final _api = Get.find<ApiService>();
  final _auth = Get.find<AuthService>();

  List<Cart> get cart => _cart;
  bool get isFetching => _isFetching.value;

  Future<void> fetchCart() async {
    try {
      _isFetching.value = true;
      final res = await _api.getCartByUserId(_auth.id!);

      if (res.isOk) {
        final cart = ParseUtil.parseList(
          list: res.body,
          fromJson: Cart.fromJson,
        ).toSet().toList();

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

        // Adding the fetched cart to the local cart, cuz the api doesn't
        // works as expected
        for (final c in cart) {
          if (!_cart.any((c) => c.id == c.id)) {
            _cart.add(c);
          }
        }

        cart.sort((a, b) => a.id!.compareTo(b.id!));
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
        // Removing localy cuz the api doesn't works as expected
        _cart.removeWhere((c) => c.id == cart.id);
        Get.snackbar(
          'success'.tr,
          'product_removed_from_cart'.tr,
          backgroundColor: Colors.green,
        );
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

  Future<void> addToCart({
    required Product? product,
    required int quantity,
  }) async {
    try {
      _isFetching.value = true;

      final res = await _api.addToCart(
        userId: _auth.id!,
        products: [
          {
            'productId': product?.id,
            'quantity': quantity,
          },
        ],
      );

      if (res.isOk) {
        //Adding localy cuz the api doesn't works as expected
        _cart.add(
          Cart(
            id: _cart.length + 10,
            userId: _auth.id,
            products: [
              CartProduct(
                productId: product?.id,
                quantity: quantity,
                product: product,
              ),
            ],
          ),
        );

        Get.snackbar(
          'success'.tr,
          'product_added_to_cart'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failed_to_add_product_to_cart'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    } finally {
      _isFetching.value = false;
    }
  }

  bool isProductInCart(int productId) {
    return _cart.any((c) => c.products!.any((p) => p.productId == productId));
  }

  @override
  void onInit() {
    fetchCart();
    super.onInit();
  }
}
