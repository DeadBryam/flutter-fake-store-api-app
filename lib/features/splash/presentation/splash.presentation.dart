import 'package:cart/features/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPresentation extends GetView<SplashController> {
  const SplashPresentation({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'INFO: SplashPresentation: build, controller: ${controller.initialized}',
    );
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TEST APP',
              style: Get.textTheme.displayLarge?.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
