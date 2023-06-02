class NewsModel {
  int? id;
  String? categoryId;
  String? subCategoryId;
  String? bannerUrl;
  String? name;
  String? date;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? customerId;
  String? isApproved;
  String? comment;
  String? cityId;

  NewsModel(
      {this.id,
        this.categoryId,
        this.subCategoryId,
        this.bannerUrl,
        this.name,
        this.date,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.customerId,
        this.isApproved,
        this.comment,
        this.cityId});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    bannerUrl = json['banner_url'] ?? "";
    name = json['name'];
    date = json['date'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerId = json['customer_id'];
    isApproved = json['is_approved'];
    comment = json['comment'] ?? "";
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['banner_url'] = bannerUrl;
    data['name'] = name;
    data['date'] = date;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['customer_id'] = customerId;
    data['is_approved'] = isApproved;
    data['comment'] = comment;
    data['city_id'] = cityId;
    return data;
  }
}