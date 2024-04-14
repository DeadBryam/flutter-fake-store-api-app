import 'package:cart/core/core.dart';
import 'package:cart/data/dto/dto.dart';
import 'package:cart/routes/app.routes.dart';
import 'package:cart/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _categories = <String>[].obs;
  final _products = <Product>[].obs;
  final _selectedCategory = 'all'.obs;

  final _filteredProducts = <Product>[].obs;

  final _searchController = TextEditingController();

  final _api = Get.find<ApiService>();
  final _auth = Get.find<AuthService>();

  List<String> get categories => _categories;
  List<Product> get products => _filteredProducts;
  TextEditingController get searchController => _searchController;
  String get selectedCategory => _selectedCategory.value;
  String get username => (_auth.user?.name?.firstname ?? 'user'.tr).capitalize!;

  Future<void> fetchCategories() async {
    try {
      final res = await _api.getCategories();

      if (res.isOk) {
        final data = ParseUtil.parseList<String>(
          list: res.body,
        );
        _categories.assignAll(['all', ...data]);
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      _categories.clear();
    }
  }

  Future<void> fetchProducts() async {
    try {
      final res = await _api.getProducts();

      if (res.isOk) {
        final data = ParseUtil.parseList<Product>(
          list: res.body,
          fromJson: Product.fromJson,
        );
        _products.assignAll(data);
        _filteredProducts.assignAll(data);
      }
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      _products.clear();
    }
  }

  void openProfile() {
    Get.toNamed<dynamic>(Routes.PROFILE);
  }

  void onSearch() {
    final filtered = _products.where((product) {
      final containsCategory = product.category == _selectedCategory.value ||
          _selectedCategory.value == 'all';
      final containsProduct =
          product.title?.contains(_searchController.text) ?? false;

      return containsProduct && containsCategory;
    });

    _filteredProducts.assignAll(filtered);
  }

  void selectCategory(String category) {
    _selectedCategory.value = category;
    onSearch();
  }

  @override
  void onInit() {
    fetchCategories();
    fetchProducts();
    super.onInit();
  }
}
