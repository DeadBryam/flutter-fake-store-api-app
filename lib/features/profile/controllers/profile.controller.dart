import 'package:cart/data/dto/user.dart';
import 'package:cart/services/services.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final _auth = Get.find<AuthService>();

  User? get user => _auth.user;
  String get fullName =>
      '${user?.name?.firstname} ${user?.name?.lastname}'.trim().capitalize!;
  String get address => [
        user?.address?.street,
        user?.address?.city,
        user?.address?.zipcode,
      ].join(', ');

  void onLogout() {
    _auth.logout();
  }
}
