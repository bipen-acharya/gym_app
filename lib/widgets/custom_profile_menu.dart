
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym_app/utils/custom_text_style.dart';

import '../utils/colors.dart';

class CustomProfileMenu extends StatelessWidget {
  final String label;
  final String iocnData;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? color;
  const CustomProfileMenu(
      {super.key,
      this.trailing,
      this.onTap,
      required this.iocnData,
      required this.label,
      this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 1.0,
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      dense: true,
      onTap: onTap,
      leading: Padding(
        padding: const EdgeInsets.only(right: 0, left: 17),
        child: SvgPicture.asset(
          iocnData,
          height: 20,
          width: 20,
          color: color ?? AppColors.primaryColor,
        ),
      ),
      title: Text(
        label,
        style: CustomTextStyles.f14W400(),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: trailing,
      ),
    );
  }
}
