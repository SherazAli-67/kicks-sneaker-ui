import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kicks_sneaker_ui/constants/number_constant.dart';
import 'package:kicks_sneaker_ui/constants/string_const.dart';
import 'package:kicks_sneaker_ui/core/app_colors.dart';
import 'package:kicks_sneaker_ui/core/app_data.dart';
import 'package:kicks_sneaker_ui/core/app_textstyles.dart';
import 'package:kicks_sneaker_ui/core/asset_res.dart';
import 'package:kicks_sneaker_ui/core/models/product_model.dart';
import 'package:kicks_sneaker_ui/presentation/providers/product_details_provider.dart';
import 'package:kicks_sneaker_ui/presentation/widgets/app_icon_button.dart';
import 'package:kicks_sneaker_ui/routing/router.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  ProductModel get _product => AppData.products.firstWhere((product) => product.id == productId, orElse: () => AppData.products.first,);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductDetailsProvider(product: _product),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Padding(
            padding: .fromLTRB(NumberConstant.horizontalPadding, NumberConstant.topContentPadding, NumberConstant.horizontalPadding, NumberConstant.bottomContentPadding,),
            child: Column(
              spacing: NumberConstant.contentGap,
              children: [
                _buildAppBar(context),
                Expanded(
                  child: Consumer<ProductDetailsProvider>(
                    builder: (context, provider, _) => CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            spacing: NumberConstant.detailsSectionGap,
                            crossAxisAlignment: .start,
                            children: [
                              _buildHeroSection(provider),
                              _buildSizeSection(provider),
                              _buildDescriptionSection(provider.product),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildAddToCartButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        AppIconButton(icon: AssetRes.icBack, onTap: () => context.pop(),),
        Expanded(child: Text(StringConst.productDetails, style: AppTextStyles.appBarTitle, textAlign: .center,),),
        AppIconButton(icon: AssetRes.icCart, onTap: () => context.go(NamedRoutes.cart.routeName),),
      ],
    );
  }

  Widget _buildHeroSection(ProductDetailsProvider provider) {
    return Column(
      spacing: NumberConstant.detailsInfoGap,
      children: [
        AspectRatio(
          aspectRatio: NumberConstant.detailsHeroAspectRatio,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.neutral100,
              borderRadius: .circular(NumberConstant.detailsHeroBorderRadius),
              border: .all(color: AppColors.neutral200),
            ),
            child: ClipRRect(
              borderRadius: .circular(NumberConstant.detailsHeroBorderRadius),
              child: Stack(
                children: [
                  Positioned.fill(child: Padding(padding: .all(NumberConstant.contentGap), child: Image.asset(provider.selectedImage, fit: .contain,),),),
                  Positioned(
                    top: NumberConstant.smallGap + NumberConstant.tinyGap,
                    right: NumberConstant.smallGap + NumberConstant.tinyGap,
                    child: GestureDetector(
                      onTap: provider.toggleFavorite,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: AppColors.neutral200, borderRadius: .circular(NumberConstant.chipBorderRadius + NumberConstant.tinyGap),),
                        child: Padding(
                          padding: .all(NumberConstant.favoriteButtonPadding),
                          child: SvgPicture.asset(AssetRes.icFavoriteOutlined, colorFilter: .mode(provider.isFavorite ? AppColors.errorColor : AppColors.neutral1000, .srcIn),),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: NumberConstant.smallGap,
                    right: NumberConstant.smallGap,
                    bottom: NumberConstant.smallGap,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: AppColors.whiteColor.withValues(alpha: 0.72), borderRadius: .circular(NumberConstant.searchBorderRadius),),
                      child: Padding(
                        padding: .symmetric(horizontal: NumberConstant.smallGap, vertical: NumberConstant.swatchStripVerticalPadding,),
                        child: Row(
                          spacing: NumberConstant.colorSwatchGap,
                          mainAxisAlignment: .center,
                          children: List.generate(provider.product.images.length, (index) {
                            final isSelected = provider.selectedImageIndex == index;
                            return GestureDetector(
                              onTap: () => provider.selectImage(index),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: .circular(NumberConstant.colorSwatchBorderRadius),
                                  border: .all(color: isSelected ? AppColors.primaryColor : AppColors.whiteColor, width: isSelected ? 1.5 : 0,),
                                ),
                                child: ClipRRect(
                                  borderRadius: .circular(NumberConstant.colorSwatchBorderRadius),
                                  child: Image.asset(provider.product.images[index], width: NumberConstant.colorSwatchSize, height: NumberConstant.colorSwatchSize, fit: .cover,),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: Column(
                spacing: NumberConstant.tinyGap,
                crossAxisAlignment: .start,
                children: [
                  Text(provider.product.name, style: AppTextStyles.detailsProductName,),
                  Text(provider.product.typeLabel, style: AppTextStyles.detailsCategory,),
                ],
              ),
            ),
            Text('\$${provider.product.price.toStringAsFixed(2)}', style: AppTextStyles.detailsPrice,),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeSection(ProductDetailsProvider provider) {
    return Column(
      spacing: NumberConstant.detailsLabelGap,
      crossAxisAlignment: .start,
      children: [
        Text(StringConst.selectSize, style: AppTextStyles.sizeLabel,),
        SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: NumberConstant.sizeChipGap,
            children: List.generate(provider.product.sizes.length, (index) {
              final isSelected = provider.selectedSizeIndex == index;
              return GestureDetector(
                onTap: () => provider.selectSize(index),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: isSelected ? AppColors.primaryColor : AppColors.neutral100, borderRadius: .circular(NumberConstant.chipBorderRadius),),
                  child: Padding(
                    padding: .symmetric(horizontal: NumberConstant.sizeChipHorizontalPadding, vertical: NumberConstant.sizeChipVerticalPadding,),
                    child: Text(provider.product.sizes[index], style: isSelected ? AppTextStyles.sizeChipSelected : AppTextStyles.sizeChip,),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(ProductModel product) {
    return Column(
      spacing: NumberConstant.detailsLabelGap,
      crossAxisAlignment: .start,
      children: [
        Text(StringConst.description, style: AppTextStyles.descriptionTitle,),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: product.description, style: AppTextStyles.descriptionBody,),
              TextSpan(text: StringConst.learnMore, style: AppTextStyles.learnMore,),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(NamedRoutes.cart.routeName),
      child: DecoratedBox(
        decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: .circular(NumberConstant.buttonBorderRadius),),
        child: Padding(
          padding: .symmetric(vertical: NumberConstant.addToCartVerticalPadding),
          child: Center(child: Text(StringConst.addToCart, style: AppTextStyles.addToCart,),),
        ),
      ),
    );
  }
}
