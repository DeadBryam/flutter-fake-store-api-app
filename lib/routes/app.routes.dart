import 'package:cart/features/features.dart';
import 'package:cart/routes/app.middleware.dart';
import 'package:get/get.dart';

class Routes {
  const Routes._();

  static const String SPLASH = '/splash';
  static const String HOME = '/home';
  static const String LOGIN = '/login';
  static const String CART = '/cart';
  static const String PRODUCT = '/product';
  static const String PROFILE = '/profile';
  static const String PRODUCT_DETAIL = '/product-detail/:id';

  static List<GetPage> routes = [
    GetPage(
      name: SPLASH,
      page: SplashPresentation.new,
      binding: SplashBinding(),
    ),
    GetPage(
      name: HOME,
      page: HomePresentation.new,
      binding: HomeBinding(),
    ),
    GetPage(
      name: LOGIN,
      page: LoginPresentation.new,
      binding: LoginBinding(),
    ),
    GetPage(
      name: PROFILE,
      page: ProfilePresentation.new,
      binding: ProfileBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: PRODUCT,
      page: ProductPresentation.new,
      binding: ProductBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: CART,
      page: CartPresentation.new,
      binding: CartBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
