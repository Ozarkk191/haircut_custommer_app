import 'package:meta/meta.dart';

class ClientAppServiceCategory {
  final String categoryNameTH;
  final String categoryNameEN;
  final int categoryId;
  final String imageUrl;
  final String topShopImageUrl;
  final List<ClientAppServiceCategory> children;
  final int parent;

  ClientAppServiceCategory({
    @required this.categoryNameTH,
    @required this.categoryNameEN,
    @required this.categoryId,
    this.imageUrl,
    this.topShopImageUrl,
    this.children,
    this.parent = 0,
  })  : assert(categoryNameTH != null),
        assert(categoryNameEN != null),
        assert(categoryId != null);
}
