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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code_name'] = codeName;
    data['field_list'] = fieldList;
    return data;
  }
}
