import 'package:flutter/material.dart';
import 'package:kicks_sneaker_ui/constants/string_const.dart';
import 'package:kicks_sneaker_ui/core/app_textstyles.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 8,
          mainAxisSize: .min,
          children: [
            Text(StringConst.cartTitle, style: AppTextStyles.sectionTitle,),
            Text(StringConst.comingSoon, style: AppTextStyles.searchHint,),
          ],
        ),
      ),
    );
  }
}
