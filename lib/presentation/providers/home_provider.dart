import 'package:flutter/material.dart';
import 'package:kicks_sneaker_ui/constants/string_const.dart';
import 'package:kicks_sneaker_ui/core/app_data.dart';
import 'package:kicks_sneaker_ui/core/models/product_model.dart';

class HomeProvider extends ChangeNotifier {
  int selectedCategoryIndex = 1;

  void selectCategory(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
  }

  List<ProductModel> get filteredProducts {
    final category = AppData.categories[selectedCategoryIndex];
    if (category == StringConst.categoryAll) return AppData.products;
    return AppData.products.where((product) => product.category == category).toList();
  }
}
