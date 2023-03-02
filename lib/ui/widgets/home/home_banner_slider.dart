import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ostad_flutter_batch_one/data/models/product_slider_model.dart';

import '../../utils/app_colors.dart';

class HomeBannerSlider extends StatelessWidget {
  HomeBannerSlider({Key? key, required this.productSliderModel})
      : super(key: key);
  final ValueNotifier<int> _currentSelectedIndex = ValueNotifier(0);
  final CarouselController _carouselController = CarouselController();
  final ProductSliderModel productSliderModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
              height: 180.0,
              autoPlay: true,
              viewportFraction: 1,
              onPageChanged: (index, _) {
                _currentSelectedIndex.value = index;
              }),
          items: productSliderModel.data?.map((slider) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: NetworkImage(slider.image ?? ''))),
                  alignment: Alignment.center,
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 4,
        ),
        ValueListenableBuilder(
          valueListenable: _currentSelectedIndex,
          builder: (context, updateValue, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < (productSliderModel.data?.length ?? 0); i++)
                  Container(
                    margin: const EdgeInsets.all(3),
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        color: i == _currentSelectedIndex.value
                            ? AppColors.primaryColor
                            : null,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: i == _currentSelectedIndex.value
                                ? AppColors.primaryColor
                                : Colors.grey)),
                  )
              ],
            );
          },
        ),
      ],
    );
  }
}
