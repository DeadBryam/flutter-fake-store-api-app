import 'package:cart/routes/app.routes.dart';
import 'package:cart/services/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  final _authService = Get.find<AuthService>();

  @override
  int? get priority => 0;

  @override
  RouteSettings? redirect(String? route) {
    return _authService.isLogged
        ? null
        : const RouteSettings(name: Routes.LOGIN);
  }
}
