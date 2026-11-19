import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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
                        _buildBanner(),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: .only(top: NumberConstant.contentGap, bottom: NumberConstant.bottomNavClearance),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: NumberConstant.productGridGap,
                        mainAxisSpacing: NumberConstant.productGridGap,
                        childAspectRatio: NumberConstant.productCardAspectRatio,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                          final product = provider.filteredProducts[index];
                          return ProductCard(product: product, onTap: () => context.push(NamedRoutes.productPath(product.id)),);
                        },
                        childCount: provider.filteredProducts.length,
                      ),
                    ),
                  ),
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
                  //profilePic, widthHeight: profileImageSize, fit.cover
                  child: const SizedBox()
                ),
              ),
              Column(
                spacing: NumberConstant.tinyGap / 2,
                crossAxisAlignment: .start,
                children: [
                  //${StringConst.helloPrefix}${StringConst.userName}, hello
                  //goodMorning, greeting
                ],
              ),
            ],
          ),
        ),
        Row(
          spacing: NumberConstant.headerActionsGap,
          children: [
            //AppIconButton: icNotification,
            //AppIconButton: icCart,
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
            //color: neutral100, searchBorderRadius
            decoration: BoxDecoration(color: Colors.transparent),
            child: Padding(
              padding: .symmetric(horizontal: NumberConstant.searchHorizontalPadding, vertical: NumberConstant.searchVerticalPadding,),
              child: Row(
                spacing: NumberConstant.smallGap,
                children: [
                  //icSearch
                  //searchHint, searchHint
                ],
              ),
            ),
          ),
        ),
        DecoratedBox(
          //primaryColor
          decoration: BoxDecoration(color: Colors.transparent, borderRadius: .circular(NumberConstant.searchBorderRadius),),
          child: Padding(
            padding: .all(NumberConstant.filterButtonPadding),
            //icFilter
            child: const SizedBox(),
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
        //categories, sectionTitle
        SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: NumberConstant.categoryChipGap,
            children: List.generate(AppData.categories.length, (index) {
              final isSelected = provider.selectedCategoryIndex == index;

              return GestureDetector(
                onTap: () => provider.selectCategory(index),
                child: DecoratedBox(
                  // isSelected ? AppColors.primaryColor : AppColors.neutral200
                  decoration: BoxDecoration(color: Colors.transparent, borderRadius: .circular(NumberConstant.chipBorderRadius),),
                  child: Padding(
                    padding: .symmetric(horizontal: NumberConstant.categoryChipHorizontalPadding, vertical: NumberConstant.categoryChipVerticalPadding,),
                    //AppData.categories[index]
                    child: Text('', style: isSelected ? AppTextStyles.categoryChipSelected : AppTextStyles.categoryChip,),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildBanner() {
    return DecoratedBox(
      //neutral100
      decoration: BoxDecoration(color: Colors.transparent, borderRadius: .circular(NumberConstant.buttonBorderRadius),),
      child: Padding(
        padding: .symmetric(horizontal: NumberConstant.contentGap, vertical: NumberConstant.smallGap,),
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
                      //newCollection, bannerTitle,
                      //discountBanner, bannerSubtitle
                    ],
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      //neutral100
                      color: Colors.transparent,
                      borderRadius: .circular(NumberConstant.chipBorderRadius),
                      //neutral400
                      border: .all(color: Colors.transparent),
                    ),
                    child: Padding(
                      padding: .symmetric(horizontal: NumberConstant.shopNowHorizontalPadding, vertical: NumberConstant.shopNowVerticalPadding,),
                      //shopNow, shopNow
                      child: const SizedBox()
                    ),
                  ),
                ],
              ),
            ),
            //newCollectionImg, fit.contain
            Expanded(child: AspectRatio(aspectRatio: 1, child: const SizedBox()),),
          ],
        ),
      ),
    );
  }
}
