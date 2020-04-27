class HomeBanner {
  final int id;
  final String imageUrl;

  @override
  HomeBanner.fromJson(Map json)
      : id = json['id'],
        imageUrl = json['imageUrl'];
}
