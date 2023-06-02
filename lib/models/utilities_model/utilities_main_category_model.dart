class UtilitiesMainCategoryModel {
  int? id;
  String? name;
  String? bannerUrl;
  String? createdAt;
  String? updatedAt;

  UtilitiesMainCategoryModel(
      {this.id, this.name, this.bannerUrl, this.createdAt, this.updatedAt});

  UtilitiesMainCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bannerUrl = json['bannerUrl'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['bannerUrl'] = bannerUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}