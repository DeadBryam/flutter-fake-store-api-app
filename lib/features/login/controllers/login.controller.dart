import 'dart:async';

import 'package:cart/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _username = TextEditingController();
  final _password = TextEditingController();

  final _isFetching = false.obs;

  final _formKey = GlobalKey<FormState>();
  final _authS = Get.find<AuthService>();

  TextEditingController get username => _username;
  TextEditingController get password => _password;
  GlobalKey<FormState> get formKey => _formKey;
  bool get isFetching => _isFetching.value;

  Future<void> login() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!_formKey.currentState!.validate()) return;

    try {
      _isFetching.value = true;
      await _authS.login(
        username: _username.text,
        password: _password.text,
      );
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      Get.snackbar(
        'error'.tr,
        'error_login'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isFetching.value = false;
    }
  }
}
