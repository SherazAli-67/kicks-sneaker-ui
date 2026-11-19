import 'package:flutter/material.dart';
import 'package:kicks_sneaker_ui/core/models/product_model.dart';

class ProductDetailsProvider extends ChangeNotifier {
  final ProductModel product;
  int selectedSizeIndex = 1;
  int selectedImageIndex = 0;
  bool isFavorite;

  ProductDetailsProvider({required this.product}) : isFavorite = product.isFavorite;

  String get selectedImage => product.images[selectedImageIndex];

  void selectSize(int index) {
    if (selectedSizeIndex == index) return;
    selectedSizeIndex = index;
    notifyListeners();
  }

  void selectImage(int index) {
    if (selectedImageIndex == index) return;
    selectedImageIndex = index;
    notifyListeners();
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
