import 'dart:async';
import 'package:cart/core/core.dart';
import 'package:cart/langs/langs.dart';
import 'package:cart/routes/app.routes.dart';
import 'package:cart/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> app() async {
  await dotenv.load();
  await GetStorage.init();
  await _initServices();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

Future<void> _initServices() async {
  Get
    ..lazyPut(ApiService.new)
    ..lazyPut(AuthService.new);
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
      theme: ThemeUtil.themeData,
      initialRoute: Routes.SPLASH,
      getPages: Routes.routes,
      locale: Translation.defaultLocale,
      fallbackLocale: Translation.defaultLocale,
      translations: Translation(),
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
