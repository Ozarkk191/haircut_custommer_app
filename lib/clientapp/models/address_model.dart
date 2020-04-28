enum AddressType { HOME, WORK }

class AddressModel {
  String addressType;
  String addressTitle;
  String address;
  double addressLat;
  double addressLon;

  AddressModel(
      {this.addressType,
      this.addressTitle,
      this.address,
      this.addressLat,
      this.addressLon});

  AddressModel.fromJson(Map<String, dynamic> json) {
    addressType = json['addressType'];
    addressTitle = json['addressTitle'];
    address = json['address'];
    addressLat = json['addressLat'];
    addressLon = json['addressLon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressType'] = this.addressType;
    data['addressTitle'] = this.addressTitle;
    data['address'] = this.address;
    data['addressLat'] = this.addressLat;
    data['addressLon'] = this.addressLon;
    return data;
  }
}
