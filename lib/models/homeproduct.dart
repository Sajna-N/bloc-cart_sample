class ProductDataModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool? isCartSelected;

  ProductDataModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isCartSelected}) {
    isCartSelected = isCartSelected ?? false;
  }

  ProductDataModel copyWith(
          {String? id,
          String? name,
          String? description,
          double? price,
          String? imageUrl,
          bool? isCartSelected}) =>
      ProductDataModel(
          id: id ?? this.id,
          name: name ?? this.name,
          description: description ?? this.description,
          price: price ?? this.price,
          imageUrl: imageUrl ?? this.imageUrl,
          isCartSelected: isCartSelected ?? this.isCartSelected);
}
