class ExtendedProfileModel {
  int? id;
  String? country;
  String? city;
  String? address;
  String? logo;

  ExtendedProfileModel(
      {this.id, this.country, this.city, this.address, this.logo});

  // JSON deserialization (fromJson) constructor
  ExtendedProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    city = json['city'];
    address = json['business_address'];
    logo = json['logo'];
    // Deserialize the list of category objects
  }
  get businessName => null;
  // JSON serialization (toJson) method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country'] = this.country;
    data['city'] = this.city;
    data['business_address'] = this.address;
    data['logo'] = this.logo;
    return data;
  }
}
