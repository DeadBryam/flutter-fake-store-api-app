import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    super.key,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(icon),
      ),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: Get.textTheme.bodySmall,
      ),
    );
  }
}
