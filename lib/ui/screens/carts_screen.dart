import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ostad_flutter_batch_one/ui/getx/cart_controller.dart';
import 'package:ostad_flutter_batch_one/ui/utils/app_colors.dart';
import 'package:ostad_flutter_batch_one/ui/widgets/app_elevated_button.dart';

import '../getx/bottom_navigation_controller.dart';
import '../widgets/carts/cart_product_item.dart';

class CartsScreen extends StatefulWidget {
  const CartsScreen({Key? key}) : super(key: key);

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  BottomNavigationController controller = Get.put(BottomNavigationController());
  CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    cartController.getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text(
            'Carts',
            style: TextStyle(color: Colors.black54),
          ),
          leading: IconButton(
            onPressed: () {
              controller.changeIndex(0);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
          ),
        ),
        body: GetBuilder<CartController>(builder: (controller) {
          if (controller.getCartListInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.cartListModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return CartProductItem(
                      cartData: controller.cartListModel.data![index],
                      onItemCountChange: (int oldCount, int newCount) {
                        final productPrice = double.tryParse(controller
                                    .cartListModel
                                    .data![index]
                                    .product
                                    ?.price ??
                                '') ??
                            0.0;
                        cartController.totalPrice -= (oldCount * productPrice);
                        final subTotalPrice = newCount * productPrice;
                        cartController.totalPrice += subTotalPrice;
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.20),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Price',
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                        Text(
                          '\$${cartController.totalPrice}',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                        width: 100,
                        child:
                            AppElevatedButton(text: 'Checkout', onTap: () {}))
                  ],
                ),
              )
            ],
          );
        }));
  }
}
