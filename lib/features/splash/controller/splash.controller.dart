import 'dart:async';

import 'package:cart/routes/app.routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _goToHome();
  }

  Future<void> _goToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    unawaited(Get.offAllNamed(Routes.HOME));
  }
}
