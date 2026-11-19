import 'package:flutter/material.dart';
import 'package:kicks_sneaker_ui/constants/string_const.dart';
import 'package:kicks_sneaker_ui/core/app_textstyles.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 8,
          mainAxisSize: .min,
          children: [
            Text(StringConst.searchTitle, style: AppTextStyles.sectionTitle,),
            Text(StringConst.comingSoon, style: AppTextStyles.searchHint,),
          ],
        ),
      ),
    );
  }
}
