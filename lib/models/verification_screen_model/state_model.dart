class StateModel {
  int? id;
  String? name;
  String? countryId;

  StateModel({this.id, this.name, this.countryId});

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['country_id'] = countryId;
    return data;
  }
}