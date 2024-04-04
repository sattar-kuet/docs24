class MailListDetailsModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? companyName;

  MailListDetailsModel(
      {this.id, this.name, this.email, this.phone, this.companyName});

  MailListDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['company_name'] = companyName;
    return data;
  }
}
