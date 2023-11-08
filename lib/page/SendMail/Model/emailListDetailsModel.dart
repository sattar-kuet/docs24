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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['company_name'] = this.companyName;
    return data;
  }
}
