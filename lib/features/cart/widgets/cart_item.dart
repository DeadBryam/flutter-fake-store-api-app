import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart/data/dto/dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItem extends StatelessWidget {
  const CartItem({required this.cart, this.onRemove, super.key});

  final Cart cart;
  final void Function(Cart)? onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              'cart_number'.trParams({'number': cart.id.toString()}),
              style: Get.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            ...(cart.products ?? []).map(
              (product) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: product.product?.image ?? '',
                      height: 650,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(product.product?.title ?? ''),
                  subtitle: Text('\$${product.product?.price}'),
                  trailing: Text('x${product.quantity}'),
                );
              },
            ),
            const Divider(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: MaterialButton(
                onPressed: () => onRemove?.call(cart),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Get.theme.primaryColor,
                child: Text(
                  'delete_from_cart'.tr,
                  style: Get.textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
