import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ostad_flutter_batch_one/ui/getx/product_controller.dart';
import 'package:ostad_flutter_batch_one/ui/widgets/product_item_preview_card.dart';

class ProductListScreen extends StatefulWidget {
  final String categoryId, categoryName;

  const ProductListScreen(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductController controller = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getProductsByCategory(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          widget.categoryName,
          style: const TextStyle(color: Colors.black54),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: GetBuilder<ProductController>(builder: (productController) {
        if (productController.productByCategoryInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if ((productController.productByCategoryModel.data?.length ?? 0) == 0) {
          return const Center(
            child: Text('No products'),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 2 / 3),
          itemCount: productController.productByCategoryModel.data?.length ?? 0,
          itemBuilder: (context, index) {
            return ProductItemPreviewCard(
              productData:
                  productController.productByCategoryModel.data![index],
            );
          },
        );
      }),
    );
  }
}
