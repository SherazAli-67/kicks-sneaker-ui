import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kicks_sneaker_ui/constants/number_constant.dart';
import 'package:kicks_sneaker_ui/core/app_colors.dart';

class AppIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color iconColor;
  final double padding;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.backgroundColor = AppColors.neutral200,
    this.iconColor = AppColors.neutral1000,
    this.padding = NumberConstant.iconButtonPadding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(color: backgroundColor, shape: .circle,),
        child: Padding(
          padding: .all(padding),
          child: SvgPicture.asset(icon, colorFilter: .mode(iconColor, .srcIn),),
        ),
      ),
    );
  }
}
