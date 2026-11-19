import 'package:flutter/material.dart';
import 'package:kicks_sneaker_ui/constants/string_const.dart';
import 'package:kicks_sneaker_ui/core/app_textstyles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 8,
          mainAxisSize: .min,
          children: [
            Text(StringConst.profileTitle, style: AppTextStyles.sectionTitle,),
            Text(StringConst.comingSoon, style: AppTextStyles.searchHint,),
          ],
        ),
      ),
    );
  }
}
