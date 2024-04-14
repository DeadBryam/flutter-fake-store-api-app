import 'package:cart/data/api/client.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  final _apiClient = ApiClient();

  Future<Response> login({
    required String username,
    required String password,
  }) {
    final body = {
      'username': username,
      'password': password,
    };

    return _apiClient.execute(
      RequestType.POST,
      'auth/login',
      body: body,
    );
  }

  Future<Response> getCategories() {
    return _apiClient.execute(
      RequestType.GET,
      'products/categories',
    );
  }

  Future<Response> getProducts() {
    return _apiClient.execute(
      RequestType.GET,
      'products',
    );
  }

  Future<Response> getProductById(int id) {
    return _apiClient.execute(
      RequestType.GET,
      'products/$id',
    );
  }

  Future<Response> getUserById(int id) {
    return _apiClient.execute(
      RequestType.GET,
      'users/$id',
    );
  }

  Future<Response> addToCart({
    required int userId,
    required List<Map<String, dynamic>> products,
  }) {
    final date = DateTime.now();
    final body = {
      'userId': userId,
      'date': date.toIso8601String(),
      'products': products,
    };

    return _apiClient.execute(
      RequestType.POST,
      'carts',
      body: body,
    );
  }

  Future<Response> getCartByUserId(int userId) {
    return _apiClient.execute(
      RequestType.GET,
      'carts/user/$userId',
    );
  }

  Future<Response> deleteCartById(int id) {
    return _apiClient.execute(
      RequestType.DELETE,
      'carts/$id',
    );
  }
}
