// Package imports:
import 'package:cart/features/login/login.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(LoginController.new);
  }
}
