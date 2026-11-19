import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kicks_sneaker_ui/constants/number_constant.dart';
import 'package:kicks_sneaker_ui/core/app_colors.dart';
import 'package:kicks_sneaker_ui/core/app_textstyles.dart';
import 'package:kicks_sneaker_ui/core/asset_res.dart';
import 'package:kicks_sneaker_ui/core/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const ProductCard({super.key, required this.product, this.onTap, this.onFavoriteTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        spacing: NumberConstant.productCardContentGap,
        crossAxisAlignment: .start,
        children: [
          AspectRatio(
            aspectRatio: NumberConstant.productImageAspectRatio,
            child: DecoratedBox(
              decoration: BoxDecoration(color: AppColors.neutral200, borderRadius: .circular(NumberConstant.cardBorderRadius),),
              child: Stack(
                children: [
                  Positioned.fill(child: Padding(padding: .all(NumberConstant.smallGap), child: Image.asset(product.image, fit: .contain,),),),
                  Positioned(
                    top: NumberConstant.smallGap,
                    right: NumberConstant.smallGap,
                    child: GestureDetector(
                      onTap: onFavoriteTap,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: AppColors.whiteColor, shape: .circle,),
                        child: Padding(
                          padding: .all(NumberConstant.favoriteButtonPadding),
                          child: SvgPicture.asset(AssetRes.icFavoriteOutlined, colorFilter: .mode(product.isFavorite ? AppColors.errorColor : AppColors.neutral1000, .srcIn),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            spacing: NumberConstant.tinyGap,
            crossAxisAlignment: .start,
            children: [
              Text(product.name, style: AppTextStyles.productName, maxLines: 1, overflow: .ellipsis,),
              Text('\$${product.price.toStringAsFixed(2)}', style: AppTextStyles.productPrice,),
            ],
          ),
        ],
      ),
    );
  }
}
