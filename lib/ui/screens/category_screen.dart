import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/ui/widgets/category_item_widget.dart';
import 'package:get/get.dart';

import '../getx/bottom_navigation_controller.dart';

class ProductCategoryScreen extends StatefulWidget {
  const ProductCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  BottomNavigationController controller = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.black54),
        ),
        leading: IconButton(
          onPressed: () {
            controller.changeIndex(0);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54,),
        ),
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount: 10,
        itemBuilder: (context, index) {
          return CategoryItemWidget(
            categoryItemName: 'ABC',
            icon: Icons.adb,
            onTap: () {},
          );
        },
      ),
    );
  }
}
