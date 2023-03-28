import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/data/models/product_details_model.dart';
import 'package:ostad_flutter_batch_one/ui/getx/cart_controller.dart';
import 'package:ostad_flutter_batch_one/ui/getx/product_details_controller.dart';
import 'package:ostad_flutter_batch_one/ui/getx/user_controller.dart';
import 'package:ostad_flutter_batch_one/ui/utils/app_colors.dart';
import 'package:ostad_flutter_batch_one/ui/widgets/inc_dec_form_field.dart';
import 'package:ostad_flutter_batch_one/ui/widgets/product_details/product_image_slider.dart';
import 'package:get/get.dart';
import 'package:ostad_flutter_batch_one/ui/widgets/snackbar_widget.dart';

import '../widgets/app_elevated_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsController _productDetailsController =
      Get.find<ProductDetailsController>();
  final UserController userController = Get.find<UserController>();

  Color? selectedColor;
  String? selectedSize;
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productDetailsController.getProductDetailsById(widget.productId);
    });
  }

  Future<void> addToCart(CartController cartController) async {
    final bool authState = userController.checkAuthState();
    if (authState &&
        selectedSize != null &&
        selectedColor != null) {
      final result = await cartController.addToCart(
          widget.productId,
          selectedSize ?? '',
          selectedColor.toString());
      if (result) {
        if (mounted) {
          showSnackBar(context, 'Added to cart!');
        }
      } else {
        if (mounted) {
          showSnackBar(context,
              'Add to cart failed! Try again', true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black54,
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.black54),
        ),
      ),
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
        if (productDetailsController.getProductDetailsInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (productDetailsController.productDetailsModel.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final ProductDetailsData productDetailsData =
              productDetailsController.productDetailsModel.data!.first;
          final List<Color> availableColors =
              getColorsFromString(productDetailsData.color ?? '');
          final List<String> availableSizes =
              getSizesFromString(productDetailsData.size ?? '');
          if (totalAmount == 0) {
            totalAmount =
                double.tryParse(productDetailsData.product?.price ?? '0.0') ??
                    0.0;
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductImageSlider(
                        sliders: [
                          productDetailsData.img1 ?? '',
                          productDetailsData.img2 ?? '',
                          productDetailsData.img3 ?? '',
                          productDetailsData.img4 ?? '',
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    productDetailsData.product?.title ?? '',
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54),
                                  ),
                                ),
                                SizedBox(
                                  width: 90,
                                  child: IncDecFormField(
                                    onChange: (oldValue, newValue) {
                                      totalAmount = (double.tryParse(
                                                  productDetailsData
                                                      .product?.price ?? '0') ??
                                              0.0) *
                                          newValue;
                                      setState(() {
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Text((productDetailsData.product?.star ?? 0.0)
                                    .toStringAsFixed(1)),
                                const SizedBox(
                                  width: 8,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Reviews',
                                    style: TextStyle(
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              'Color',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (int i = 0;
                                      i < availableColors.length;
                                      i++)
                                    GestureDetector(
                                      onTap: () {
                                        selectedColor = availableColors[i];
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: availableColors[i],
                                          child: selectedColor ==
                                                  availableColors[i]
                                              ? const Icon(Icons.check)
                                              : null,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              'Size',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (int i = 0;
                                      i < availableSizes.length;
                                      i++)
                                    GestureDetector(
                                      onTap: () {
                                        selectedSize = availableSizes[i];
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: selectedSize ==
                                                      availableSizes[i]
                                                  ? AppColors.primaryColor
                                                      .withOpacity(0.8)
                                                  : null,
                                              border: Border.all(
                                                  color: Colors.black54,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Text(availableSizes[i]),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              'Description',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              productDetailsData.des ?? '',
                              style: const TextStyle(
                                  fontSize: 13,
                                  letterSpacing: 0.2,
                                  color: Colors.black54),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                          '\$$totalAmount',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 120,
                      child: GetBuilder<CartController>(
                        builder: (cartController) {
                          if (cartController.addToCartInProgress) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return AppElevatedButton(
                            text: 'Add To Cart',
                            onTap: () =>
                              addToCart(cartController),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
      }),
    );
  }

  List<Color> getColorsFromString(String colors) {
    List<Color> hexaColors = [];
    final List<String> allColors = colors.split(',');
    for (var element in allColors) {
      hexaColors.add(HexColor(element));
    }
    return hexaColors;
  }

  List<String> getSizesFromString(String sizes) {
    return sizes.split(',');
  }
}
