class EmailDataModel {
  String? receiver_name;
  String? receiver_email;
  String? sender_date;
  String? project_name;
  String? client_name;
  String? project_address;
  String? template_id;


  EmailDataModel({this.receiver_name, this.receiver_email, this.sender_date, 
  this.project_name, this.client_name, this.project_address, this.template_id});

  EmailDataModel.fromJson(Map<String, dynamic> json) {
    receiver_name = json['receiver_name'];
    receiver_email = json['receiver_email'];
    sender_date = json['sender_date'];
    project_name = json['project_name'];
    client_name = json['client_name'];
    project_address = json['project_address'];
    template_id = json['template_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['receiver_name'] = receiver_name;
    data['receiver_email'] = receiver_email;
    data['sender_date'] = sender_date;
    data['project_name'] = project_name;
    data['client_name'] = client_name;
    data['project_address'] = project_address;
    data['template_id'] = template_id;
    return data;
  }
}
