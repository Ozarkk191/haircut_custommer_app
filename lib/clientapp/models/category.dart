import 'package:meta/meta.dart';

class Category {
  final String categoryNameTH;
  final String categoryNameEN;
  final int categoryId;
  final String imageUrl;

  Category({
    @required this.categoryNameTH,
    @required this.categoryNameEN,
    @required this.categoryId,
    @required this.imageUrl,
  })  : assert(categoryNameTH != null),
        assert(categoryNameEN != null),
        assert(categoryId != null),
        assert(imageUrl != null);
}
