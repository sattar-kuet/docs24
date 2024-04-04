
class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  String? isoCountryCode;
  String? position;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.countryCode,
    this.isoCountryCode,
    this.position,
  });

  // JSON deserialization (fromJson) constructor
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    position = json['position'];
    countryCode = json['country_code'];
    isoCountryCode = json['iso_country_code'];
    // Deserialize the list of category objects
  }

  // JSON serialization (toJson) method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['position'] = position;
    data['country_code'] = countryCode;
    data['iso_country_code'] = isoCountryCode;
    return data;
  }
}
