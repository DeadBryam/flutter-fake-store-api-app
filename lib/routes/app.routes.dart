import 'package:cart/features/features.dart';
import 'package:get/get.dart';

class Routes {
  const Routes._();

  static const String SPLASH = '/splash';
  static const String HOME = '/home';
  static const String LOGIN = '/login';
  static const String CART = '/cart';
  static const String PRODUCT = '/product';

  static List<GetPage> routes = [
    GetPage(
      name: SPLASH,
      page: SplashPresentation.new,
      binding: SplashBinding(),
    ),
  ];
}
