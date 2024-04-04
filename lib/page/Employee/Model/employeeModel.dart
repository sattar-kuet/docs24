import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class EmployeeModel extends Equatable {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  String? countryISOCode;
  String? position;

  EmployeeModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.countryCode,
      this.countryISOCode,
      this.position});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    countryISOCode = json['country_iso_code'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['country_code'] = countryCode;
    data['country_iso_code'] = countryISOCode;
    data['position'] = position;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, phone, email, position];
}
