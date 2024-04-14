import 'dart:async';

import 'package:cart/core/utils/parse.dart';
import 'package:cart/data/dto/dto.dart';
import 'package:cart/routes/app.routes.dart';
import 'package:cart/services/api.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService extends GetxService {
  AuthService() {
    _init();
  }

  final _token = ''.obs;
  final _id = Rxn<int>();
  final _user = Rxn<User>();

  final _box = GetStorage();

  final _api = Get.find<ApiService>();

  String get token => _token.value;
  bool get isLogged => _token.value.isNotEmpty;
  int? get id => _id.value;
  User? get user => _user.value;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      final res = await _api.login(
        username: username,
        password: password,
      );

      if (res.isOk) {
        final body = res.body as Map<String, dynamic>? ?? {};
        _token.value = body['token'] as String? ?? '';

        if (_token.value.isNotEmpty) {
          final decoded = JwtDecoder.decode(_token.value);
          _id.value = decoded['sub'] as int?;

          await _box.write('_token', _token.value);

          await fetchUser();
          unawaited(
            Get.offNamedUntil<dynamic>(
              Routes.HOME,
              (route) => route.isFirst,
            ),
          );
        } else {
          throw Exception('error_login'.tr);
        }
      } else {
        throw Exception('error_login'.tr);
      }
    } catch (_) {
      Get.snackbar(
        'error'.tr,
        'error_login'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchUser() async {
    try {
      if (_id.value == null) return;
      final res = await _api.getUserById(_id.value!);

      if (res.isOk) {
        _user.value = ParseUtil.parse(
          json: res.body,
          fromJson: User.fromJson,
        );
      }
    } catch (_) {
      Get.snackbar(
        'error'.tr,
        'error_fetch_user'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void logout() {
    _token.value = '';
    _user.value = null;
    Get.offNamedUntil<dynamic>(Routes.HOME, (route) => route.isFirst);
  }

  Future<void> _init() async {
    final token = _box.read<String?>('_token');
    if (token != null) {
      _token.value = token;
      final decoded = JwtDecoder.decode(token);
      _id.value = decoded['sub'] as int?;
      await fetchUser();
    }
  }
}
