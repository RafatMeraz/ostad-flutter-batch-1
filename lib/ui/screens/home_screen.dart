import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ostad_flutter_batch_one/ui/getx/home_controller.dart';

import '../widgets/category_item_widget.dart';
import '../widgets/home/home_banner_slider.dart';
import '../widgets/home/section_header.dart';
import '../widgets/product_item_preview_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.getProductSliderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: SvgPicture.asset('assets/images/logo_nav.svg'),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: 16,
            child: Icon(
              Icons.person,
              size: 18,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: 16,
            child: Icon(
              Icons.call,
              size: 18,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              radius: 16,
              child: Icon(
                Icons.notifications,
                size: 18,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                    hintText: 'Search',
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              const SizedBox(
                height: 16,
              ),
              GetBuilder<HomeController>(
                builder: (homeController) {
                  if (homeController.getProductSliderInProgress) {
                    return const CircularProgressIndicator();
                  } else {
                    return HomeBannerSlider(
                      productSliderModel: homeController.productSliderModel,
                    );
                  }
                }
              ),
              SectionHeader(
                headerName: 'Categories',
                onTapSeeAll: () {},
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryItemWidget(
                      onTap: () {},
                      icon: Icons.computer,
                      categoryItemName: 'Electronics',
                    ),
                    CategoryItemWidget(
                      onTap: () {},
                      icon: Icons.add_business,
                      categoryItemName: 'Tools',
                    ),
                    CategoryItemWidget(
                      onTap: () {},
                      icon: Icons.computer,
                      categoryItemName: 'Electronics',
                    ),
                    CategoryItemWidget(
                      onTap: () {},
                      icon: Icons.add_business,
                      categoryItemName: 'Tools',
                    ),
                    CategoryItemWidget(
                      onTap: () {},
                      icon: Icons.computer,
                      categoryItemName: 'Electronics',
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SectionHeader(headerName: 'Popular', onTapSeeAll: () {}),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SectionHeader(headerName: 'Special', onTapSeeAll: () {}),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SectionHeader(headerName: 'New', onTapSeeAll: () {}),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}