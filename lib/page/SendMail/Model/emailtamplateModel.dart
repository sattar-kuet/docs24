class EmailTamplateModel {
  int? id;
  String? name;
  String? codeName;
  List<String>? fieldList;

  EmailTamplateModel({this.id, this.name, this.codeName, this.fieldList});

  EmailTamplateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    codeName = json['code_name'];
    fieldList = json['field_list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code_name'] = this.codeName;
    data['field_list'] = this.fieldList;
    return data;
  }
}
