import 'package:cart/core/core.dart';
import 'package:cart/features/features.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePresentation extends GetView<ProfileController> {
  const ProfilePresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.grey.shade200,
                      child: Icon(
                        Icons.person_rounded,
                        size: 150,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ProfileTile(
                      icon: Icons.account_circle_rounded,
                      title: 'name'.tr,
                      subtitle: controller.fullName,
                      color: ColorsUtil.tertiaryColor,
                    ),
                    ProfileTile(
                      icon: Icons.person,
                      title: 'username'.tr,
                      subtitle: controller.user?.username ?? '',
                      color: ColorsUtil.tertiaryColor,
                    ),
                    ProfileTile(
                      icon: Icons.phone,
                      title: 'phone'.tr,
                      subtitle: controller.user?.phone ?? '',
                      color: ColorsUtil.tertiaryColor,
                    ),
                    ProfileTile(
                      icon: Icons.email,
                      title: 'email'.tr,
                      subtitle: controller.user?.email ?? '',
                      color: ColorsUtil.tertiaryColor,
                    ),
                    ProfileTile(
                      icon: Icons.location_on_rounded,
                      title: 'address'.tr,
                      subtitle: controller.address,
                      color: ColorsUtil.tertiaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.onLogout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('logout'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
