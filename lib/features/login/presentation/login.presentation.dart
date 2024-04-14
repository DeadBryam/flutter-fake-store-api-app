import 'package:cart/features/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPresentation extends GetWidget<LoginController> {
  const LoginPresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: Get.height * 0.8,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_rounded,
                  size: 150,
                  color: Get.theme.primaryColor,
                ),
                const SizedBox(height: 10),
                Text(
                  'login'.tr,
                  style: Get.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'login_description'.tr,
                  style: Get.textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'username_required'.tr;
                    }
                    return null;
                  },
                  controller: controller.username,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    hintText: 'username'.tr,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password_required'.tr;
                    }
                    return null;
                  },
                  controller: controller.password,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    hintText: 'password'.tr,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.maxFinite,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed:
                          controller.isFetching ? null : controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Get.theme.primaryColor,
                        disabledBackgroundColor:
                            Get.theme.primaryColor.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                      ),
                      child: Text(
                        'login'.tr,
                        style: Get.textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
