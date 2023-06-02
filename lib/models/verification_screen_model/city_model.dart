class CityModel {
  int? id;
  String? name;
  String? stateId;
  String? updatedAt;
  String? createdAt;
  bool? isCitySelected;

  CityModel({this.id, this.name, this.stateId, this.updatedAt, this.createdAt});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['city'];
    stateId = json['state_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    isCitySelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['city'] = name;
    data['state_id'] = stateId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}