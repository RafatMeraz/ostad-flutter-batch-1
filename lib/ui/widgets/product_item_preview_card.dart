import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/ui/screens/product_details_screen.dart';

import '../utils/app_colors.dart';

class ProductItemPreviewCard extends StatelessWidget {
  const ProductItemPreviewCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ProductDetailsScreen()));
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Image.asset(
              'assets/images/product.png',
              height: 80,
              width: 160,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              'Product name',
              maxLines: 2,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Colors.black54,
                  letterSpacing: 0.4,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$800',
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  Icons.star,
                  color: Colors.amberAccent,
                  size: 14,
                ),
                const Text(
                  '4.5',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Icon(
                          Icons.favorite_border,
                          size: 10,
                          color: Colors.white,
                        )))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
