class CateModel {
  final String id;

  final String title;
  final String image;

  CateModel({required this.id, required this.title, required this.image});
}

class ProductsModel {
  final String id;

  final String title;
  final String image;
  final String brand;
  final String stock;
  final String discount;
  final String size;
  final int price;
  final int splPrice;

  ProductsModel({
    required this.id,
    required this.title,
    required this.image,
    required this.brand,
    required this.discount,
    required this.price,
    required this.size,
    required this.splPrice,
    required this.stock,
  });
}
