import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/data/models/cart_list_model.dart';
import 'package:get/get.dart';
import 'package:ostad_flutter_batch_one/ui/getx/cart_controller.dart';
import 'package:ostad_flutter_batch_one/ui/screens/product_details_screen.dart';
import 'package:ostad_flutter_batch_one/ui/widgets/snackbar_widget.dart';

import '../../utils/app_colors.dart';
import '../inc_dec_form_field.dart';

class CartProductItem extends StatelessWidget {
  CartProductItem({
    Key? key, required this.cartData, required this.onItemCountChange,
  }) : super(key: key);

  final CartData cartData;
  final Function(int, int) onItemCountChange;
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ProductDetailsScreen(productId: cartData.product!.id!));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        elevation: 2,
        child: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Image.network(
              cartData.product?.image ?? '',
              width: 90,
              height: 70,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartData.product?.title ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    letterSpacing: 0.4),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Color : ${cartData.color ?? ''}',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    'Size : ${cartData.size ?? ''}',
                                    maxLines: 1,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            log(cartData.id.toString());
                            cartController.deleteCart(cartData.id!).then((result) {
                              if (result) {
                                cartController.getCartList();
                              } else {
                                showSnackBar(context, 'Cart item deletion failed!', true);
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${cartData.product?.price ?? 0}',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 95,
                          height: 30,
                          child: IncDecFormField(
                            onChange: (oldValue, newValue) {
                              onItemCountChange(oldValue, newValue);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
