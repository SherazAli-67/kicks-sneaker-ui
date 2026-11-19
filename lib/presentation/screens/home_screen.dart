import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kicks_sneaker_ui/constants/animation_constant.dart';
import 'package:kicks_sneaker_ui/constants/number_constant.dart';
import 'package:kicks_sneaker_ui/constants/string_const.dart';
import 'package:kicks_sneaker_ui/core/app_colors.dart';
import 'package:kicks_sneaker_ui/core/app_data.dart';
import 'package:kicks_sneaker_ui/core/app_textstyles.dart';
import 'package:kicks_sneaker_ui/core/asset_res.dart';
import 'package:kicks_sneaker_ui/presentation/providers/home_provider.dart';
import 'package:kicks_sneaker_ui/presentation/widgets/app_icon_button.dart';
import 'package:kicks_sneaker_ui/presentation/widgets/product_card.dart';
import 'package:kicks_sneaker_ui/routing/router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Padding(
            padding: .fromLTRB(NumberConstant.horizontalPadding, NumberConstant.topContentPadding, NumberConstant.horizontalPadding, 0),
            child: Consumer<HomeProvider>(
              builder: (context, provider, _) => CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      spacing: NumberConstant.contentGap,
                      children: [
                        _buildHeader(context),
                        _buildSearchRow(),
                        _buildCategoriesSection(provider),
                        _buildBanner(context),
                      ],
                    ),
                  ),
                  _buildProductGrid(context, provider),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            spacing: NumberConstant.headerProfileGap,
            children: [
              ClipRRect(
                borderRadius: .circular(NumberConstant.profileImageBorderRadius),
                child: ColoredBox(
                  color: AppColors.neutral200,
                  child: Image.asset(AssetRes.profilePic, width: NumberConstant.profileImageSize, fit: .contain),
                ),
              ),
              Column(
                spacing: NumberConstant.tinyGap / 2,
                crossAxisAlignment: .start,
                children: [
                  Text('${StringConst.helloPrefix}${StringConst.userName}', style: AppTextStyles.hello),
                  Text(StringConst.goodMorning, style: AppTextStyles.greeting),
                ],
              ),
            ],
          ),
        ),
        Row(
          spacing: NumberConstant.headerActionsGap,
          children: [
            AppIconButton(icon: AssetRes.icNotification),
            AppIconButton(icon: AssetRes.icCart),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchRow() {
    return Row(
      spacing: NumberConstant.searchFilterGap,
      children: [
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(color: AppColors.neutral100),
            child: Padding(
              padding: .symmetric(horizontal: NumberConstant.searchHorizontalPadding, vertical: NumberConstant.searchVerticalPadding),
              child: Row(
                spacing: NumberConstant.smallGap,
                children: [
                  SvgPicture.asset(AssetRes.icSearch),
                  Text(StringConst.searchHint, style: AppTextStyles.searchHint),
                ],
              ),
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: .circular(NumberConstant.searchBorderRadius)),
          child: Padding(
            padding: .all(NumberConstant.filterButtonPadding),
            child: SvgPicture.asset(AssetRes.icFilter),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection(HomeProvider provider) {
    return Column(
      spacing: NumberConstant.categoriesTitleGap,
      crossAxisAlignment: .start,
      children: [
        SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: NumberConstant.categoryChipGap,
            children: List.generate(AppData.categories.length, (index) {
              final isSelected = provider.selectedCategoryIndex == index;

              return GestureDetector(
                onTap: () => provider.selectCategory(index),
                child: AnimatedContainer(
                  duration: AnimationConstant.selection,
                  curve: AnimationConstant.selectionCurve,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor : AppColors.neutral200,
                    borderRadius: .circular(NumberConstant.chipBorderRadius),
                  ),
                  child: Padding(
                    padding: .symmetric(
                      horizontal: NumberConstant.categoryChipHorizontalPadding,
                      vertical: NumberConstant.categoryChipVerticalPadding,
                    ),
                    child: AnimatedDefaultTextStyle(
                      duration: AnimationConstant.selection,
                      curve: AnimationConstant.selectionCurve,
                      style: isSelected ? AppTextStyles.categoryChipSelected : AppTextStyles.categoryChip,
                      child: Text(AppData.categories[index]),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildBanner(BuildContext context) {
    final banner = DecoratedBox(
      decoration: BoxDecoration(color: AppColors.neutral100, borderRadius: .circular(NumberConstant.buttonBorderRadius)),
      child: Padding(
        padding: .symmetric(horizontal: NumberConstant.contentGap, vertical: NumberConstant.smallGap),
        child: Row(
          spacing: NumberConstant.contentGap,
          children: [
            Expanded(
              child: Column(
                spacing: NumberConstant.bannerContentGap,
                crossAxisAlignment: .start,
                children: [
                  Column(
                    spacing: NumberConstant.tinyGap,
                    crossAxisAlignment: .start,
                    children: [
                      Text(StringConst.newCollection, style: AppTextStyles.bannerTitle),
                      Text(StringConst.discountBanner, style: AppTextStyles.bannerSubtitle),
                    ],
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.neutral100,
                      borderRadius: .circular(NumberConstant.chipBorderRadius),
                      border: .all(color: AppColors.neutral400),
                    ),
                    child: Padding(
                      padding: .symmetric(
                        horizontal: NumberConstant.shopNowHorizontalPadding,
                        vertical: NumberConstant.shopNowVerticalPadding,
                      ),
                      child: Text(StringConst.shopNow, style: AppTextStyles.shopNow),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(AssetRes.newCollectionImg, fit: .contain),
              ),
            ),
          ],
        ),
      ),
    );

    if (MediaQuery.disableAnimationsOf(context)) return banner;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: AnimationConstant.entrance,
      curve: AnimationConstant.entranceCurve,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, AnimationConstant.entranceSlideOffset * (1 - value)),
            child: child,
          ),
        );
      },
      child: banner,
    );
  }

  Widget _buildProductGrid(BuildContext context, HomeProvider provider) {
    final products = provider.filteredProducts;
    final categoryIndex = provider.selectedCategoryIndex;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return SliverPadding(
      padding: .only(top: NumberConstant.contentGap, bottom: NumberConstant.bottomNavClearance),
      sliver: products.isEmpty
          ? const SliverToBoxAdapter(child: SizedBox.shrink())
          : SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: NumberConstant.productGridGap,
                mainAxisSpacing: NumberConstant.productGridGap,
                childAspectRatio: NumberConstant.productCardAspectRatio,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = products[index];
                  final card = ProductCard(
                    product: product,
                    onTap: () => context.push(NamedRoutes.productPath(product.id)),
                  );

                  if (reduceMotion) return card;

                  final staggerStart = (index * AnimationConstant.staggerStep).clamp(0.0, AnimationConstant.staggerMaxStart);

                  return TweenAnimationBuilder<double>(
                    key: ValueKey('grid-$categoryIndex-${product.id}'),
                    tween: Tween(begin: 0, end: 1),
                    duration: AnimationConstant.gridItem,
                    curve: Interval(staggerStart, 1, curve: AnimationConstant.gridCurve),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, AnimationConstant.gridSlideOffset * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: card,
                  );
                },
                childCount: products.length,
              ),
            ),
    );
  }
}
