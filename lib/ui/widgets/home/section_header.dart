import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key,
    required this.headerName,
    required this.onTapSeeAll,
  }) : super(key: key);

  final String headerName;
  final VoidCallback onTapSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          headerName,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.6),
        ),
        TextButton(
          onPressed: onTapSeeAll,
          child: Text(
            'See all',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        )
      ],
    );
  }
}
