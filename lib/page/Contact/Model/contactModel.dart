import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ContactModel extends Equatable {
  int? id;
  int? uid;
  String? name;
  String? email;
  String? phone;
  String? countryCode;
  String? countryISOCode;
  String? companyName;

  ContactModel(
      {this.id,
      this.uid,
      this.name,
      this.email,
      this.phone,
      this.countryCode,
      this.countryISOCode,
      this.companyName});

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    countryISOCode = json['country_iso_code'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['country_code'] = countryCode;
    data['country_iso_code'] = countryISOCode;
    data['company_name'] = companyName;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, phone, email, uid, companyName];
}
