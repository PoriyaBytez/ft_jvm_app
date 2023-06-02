class CityStateWiseModel {
  int? id;
  String? city;
  int? stateId;
  String? updatedAt;
  String? createdAt;

  CityStateWiseModel(
      {this.id, this.city, this.stateId, this.updatedAt, this.createdAt});

  CityStateWiseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    stateId = json['state_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city'] = city;
    data['state_id'] = stateId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}