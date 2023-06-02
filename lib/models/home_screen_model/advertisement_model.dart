class AdvertisementModel {
  int? id;
  String? name;
  String? advertisementName;
  String? description;
  String? bannerUrl;
  String? createdAt;
  String? updatedAt;
  String? customerId;
  String? cityId;
  String? slideId;
  String? isApproved;
  String? comment;
  String? toDate;

  AdvertisementModel(
      {this.id,
        this.name,
        this.advertisementName,
        this.description,
        this.bannerUrl,
        this.createdAt,
        this.updatedAt,
        this.customerId,
        this.cityId,
        this.slideId,
        this.isApproved,
        this.comment,
        this.toDate});

  AdvertisementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    advertisementName = json['advertisement_name'];
    description = json['description'];
    bannerUrl = json['banner_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerId = json['customer_id'];
    cityId = json['city_id'];
    slideId = json['slide_id'];
    isApproved = json['is_approved'];
    comment = json['comment'] ?? "";
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['advertisement_name'] = advertisementName;
    data['description'] = description;
    data['banner_url'] = bannerUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['customer_id'] = customerId;
    data['city_id'] = cityId;
    data['slide_id'] = slideId;
    data['is_approved'] = isApproved;
    data['comment'] = comment;
    data['to_date'] = toDate;
    return data;
  }
}