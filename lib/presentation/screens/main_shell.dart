import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kicks_sneaker_ui/constants/number_constant.dart';
import 'package:kicks_sneaker_ui/core/app_colors.dart';
import 'package:kicks_sneaker_ui/core/asset_res.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: .only(left: NumberConstant.horizontalPadding * 2, right: NumberConstant.horizontalPadding * 2, bottom: NumberConstant.bottomContentPadding,),
          child: DecoratedBox(
            decoration: BoxDecoration(color: AppColors.neutral1000, borderRadius: .circular(NumberConstant.bottomNavBorderRadius),),
            child: Padding(
              padding: .symmetric(horizontal: NumberConstant.bottomNavHorizontalPadding, vertical: NumberConstant.bottomNavVerticalPadding,),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  _buildNavItem(index: 0, icon: AssetRes.icHome),
                  _buildNavItem(index: 1, icon: AssetRes.icSearch),
                  _buildNavItem(index: 2, icon: AssetRes.icCart),
                  _buildNavItem(index: 3, icon: AssetRes.icProfile),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required int index, required String icon}) {
    final isSelected = navigationShell.currentIndex == index;
    return GestureDetector(
      onTap: () => navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex,),
      child: DecoratedBox(
        decoration: BoxDecoration(color: isSelected ? AppColors.primaryColor : AppColors.neutral1000, shape: .circle,),
        child: Padding(
          padding: .all(NumberConstant.bottomNavItemPadding),
          child: SvgPicture.asset(icon, colorFilter: .mode(AppColors.whiteColor, .srcIn),),
        ),
      ),
    );
  }
}
