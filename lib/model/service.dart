class Service {
  final int id;
  final String name;
  final String iconUrl;
  final int price;
  final List<Service> children = new List<Service>();

  Service.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        iconUrl = json['iconUrl'],
        price = json['price'] {
    if (json['children'] != null) {
      json['children'].forEach((service) {
        children.add(new Service.fromJson(service));
      });
    }
  }
}
