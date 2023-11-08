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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['country_code'] = this.countryCode;
    data['country_iso_code'] = this.countryISOCode;
    data['company_name'] = this.companyName;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, phone, email, uid, companyName];
}
