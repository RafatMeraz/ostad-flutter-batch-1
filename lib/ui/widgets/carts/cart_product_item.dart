import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../inc_dec_form_field.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      child: Row(
        children: [
          const SizedBox(
            width: 8,
          ),
          Image.asset(
            'assets/images/product.png',
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Product name',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                letterSpacing: 0.4),
                          ),
                          Row(
                            children: const [
                              Text(
                                'Color : Black',
                                style: TextStyle(fontSize: 13),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Size : XL',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
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
                        '\$100',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      const SizedBox(
                        width: 95,
                        height: 30,
                        child: IncDecFormField(),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
