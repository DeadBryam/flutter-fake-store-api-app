import 'dart:async';
import 'package:cart/routes/app.routes.dart';
import 'package:cart/services/api.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Future<void> app() async {
  await dotenv.load();
  await _initServices();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

Future<void> _initServices() async {
  Get.lazyPut(ApiService.new);
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TEST APP',
      scrollBehavior: const ScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
        ),
      ),
      initialRoute: Routes.SPLASH,
      getPages: Routes.routes,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
