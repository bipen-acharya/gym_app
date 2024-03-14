import 'package:flutter/material.dart';
import 'package:gym_app/utils/custom_text_style.dart';

import '../../utils/colors.dart';

class CustomBottomNavIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  const CustomBottomNavIcon({
    super.key,
    required this.title,
    required this.isActive,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 30,
              color: isActive ? AppColors.backGroundColor : Colors.grey,
            ),
            Text(
              title,
              style: CustomTextStyles.f14W400(
                color: isActive ? AppColors.backGroundColor : Colors.grey,
              ),
            )
          ],
        ));
  }
}
