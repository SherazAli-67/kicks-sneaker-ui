class ProductModel {
  final String id;
  final String name;
  final String category;
  final String typeLabel;
  final double price;
  final String image;
  final List<String> images;
  final String description;
  final List<String> sizes;
  final bool isFavorite;

  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.typeLabel,
    required this.price,
    required this.image,
    required this.images,
    required this.description,
    required this.sizes,
    this.isFavorite = false,
  });
}
