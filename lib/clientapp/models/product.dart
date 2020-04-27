import 'package:meta/meta.dart';

class Product {
  final String productName;
  final String productDescription;
  final int categoryId;
  final double price;
  final double salePrice;
  final List<String> productImageUrl;
  final double rating;
  final int shopId;
  final int stockLevel;
  final String brand;
  final String licence;
  final String sendFrom;

  Product({
    @required this.productName,
    @required this.productDescription,
    @required this.categoryId,
    @required this.price,
    this.salePrice,
    @required this.productImageUrl,
    @required this.shopId,
    this.rating = 0,
    this.stockLevel = 0,
    this.brand,
    this.licence,
    @required this.sendFrom,
  })  : assert(productName != null),
        assert(categoryId != null),
        assert(sendFrom != null),
        assert(price != null),
        assert(productImageUrl != null),
        assert(shopId != null);
}
