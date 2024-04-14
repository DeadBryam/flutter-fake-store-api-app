import 'package:cart/data/dto/dto.dart';
import 'package:cart/services/services.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final _cart = Get.find<CartService>();

  List<Cart> get cart => _cart.cart;
  bool get isFetching => _cart.isFetching;

  void removeProductFromCart(Cart cart) {
    _cart.removeProductFromCart(cart);
  }

  void reloadCart() {
    _cart.fetchCart();
  }

  @override
  void onReady() {
    _cart.fetchCart();
    super.onReady();
  }
}
