// class UtilitiesModel {
//   int? currentPage;
//   List<UtilitiesModel>? UtilitiesModel;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Links>? links;
//   String? nextPageUrl;
//   String? path;
//   int? perPage;
//   String? prevPageUrl;
//   int? to;
//   int? total;
//
//   UtilitiesModel(
//       {this.currentPage,
//         this.UtilitiesModel,
//         this.firstPageUrl,
//         this.from,
//         this.lastPage,
//         this.lastPageUrl,
//         this.links,
//         this.nextPageUrl,
//         this.path,
//         this.perPage,
//         this.prevPageUrl,
//         this.to,
//         this.total});
//
//   UtilitiesModel.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['UtilitiesModel'] != null) {
//       UtilitiesModel = <UtilitiesModel>[];
//       json['UtilitiesModel'].forEach((v) {
//         UtilitiesModel!.add(UtilitiesModel.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     if (json['links'] != null) {
//       links = <Links>[];
//       json['links'].forEach((v) {
//         links!.add(Links.fromJson(v));
//       });
//     }
//     nextPageUrl = json['next_page_url'] ?? "";
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'] ?? "";
//     to = json['to'];
//     total = json['total'];
//   }
// }

class UtilitiesModel {
  int? id;
  String? bannerUrl;
  String? name;
  String? phoneNo;
  String? officeNo;
  String? address;
  String? countryId;
  String? stateId;
  String? cityId;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? customerId;
  String? isApproved;
  String? comment;
  String? otherFile;
  String? categoryId;
  String? subCategoryId;

  UtilitiesModel(
      {this.id,
        this.bannerUrl,
        this.name,
        this.phoneNo,
        this.officeNo,
        this.address,
        this.countryId,
        this.stateId,
        this.cityId,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.customerId,
        this.isApproved,
        this.comment,
        this.otherFile,
        this.categoryId,
        this.subCategoryId});

  UtilitiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerUrl = json['banner_url'];
    name = json['name'];
    phoneNo = json['phone_no'];
    officeNo = json['office_no'];
    address = json['address'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerId = json['customer_id'];
    isApproved = json['is_approved'];
    comment = json['comment'] ?? "";
    otherFile = json['other_file'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
}