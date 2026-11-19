import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kicks_sneaker_ui/constants/number_constant.dart';
import 'package:kicks_sneaker_ui/constants/string_const.dart';
import 'package:kicks_sneaker_ui/core/app_textstyles.dart';
import 'package:kicks_sneaker_ui/core/asset_res.dart';
import 'package:kicks_sneaker_ui/presentation/widgets/app_icon_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: .symmetric(horizontal: NumberConstant.horizontalPadding, vertical: NumberConstant.smallGap,),
              child: Row(
                children: [
                  AppIconButton(icon: AssetRes.icBack, onTap: () => context.pop(),),
                  Expanded(child: Text(StringConst.productDetails, style: AppTextStyles.appBarTitle, textAlign: .center,),),
                  AppIconButton(icon: AssetRes.icCart,),
                ],
              ),
            ),
            Expanded(child: Center(child: Text(productId, style: AppTextStyles.sectionTitle,),),),
          ],
        ),
      ),
    );
  }
}
