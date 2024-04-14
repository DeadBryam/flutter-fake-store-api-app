import 'package:cart/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    required this.category,
    this.onTap,
    super.key,
    this.isSelected = false,
  });

  final String category;
  final bool isSelected;
  final void Function(String)? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: isSelected ? ColorsUtil.secondaryColor : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => onTap?.call(category),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Center(child: Text(category.capitalizeFirst!)),
        ),
      ),
    );
  }
}
