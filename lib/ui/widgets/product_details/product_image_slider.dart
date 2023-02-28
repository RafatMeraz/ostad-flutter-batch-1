import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../utils/app_colors.dart';

class ProductImageSlider extends StatelessWidget {
  ProductImageSlider({Key? key}) : super(key: key);
  final ValueNotifier<int> _currentSelectedIndex = ValueNotifier(0);
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
              height: 230.0,
              viewportFraction: 1,
              onPageChanged: (index, _) {
                _currentSelectedIndex.value = index;
              }),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/product.png'),
                        fit: BoxFit.cover
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'text $i',
                      style: const TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ValueListenableBuilder(
                  valueListenable: _currentSelectedIndex,
                  builder: (context, updateValue, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 5; i++)
                          Container(
                            margin: const EdgeInsets.all(3),
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                                color: i == _currentSelectedIndex.value
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: i == _currentSelectedIndex.value
                                        ? AppColors.primaryColor
                                        : Colors.white)),
                          )
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
