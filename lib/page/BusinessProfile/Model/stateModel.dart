class StateModel {
  int? id;
  int? countryId;
  String? name;

  StateModel({this.id, this.countryId, this.name});

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id = json['country_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['name'] = this.name;
    return data;
  }
}
