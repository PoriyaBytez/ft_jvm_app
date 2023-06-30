// class MatrimonyModel {
//   int? currentPage;
//   List<Data>? data;
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
//   MatrimonyModel(
//       {this.currentPage,
//         this.data,
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
//   MatrimonyModel.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
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
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['current_page'] = currentPage;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['first_page_url'] = firstPageUrl;
//     data['from'] = from;
//     data['last_page'] = lastPage;
//     data['last_page_url'] = lastPageUrl;
//     if (links != null) {
//       data['links'] = links!.map((v) => v.toJson()).toList();
//     }
//     data['next_page_url'] = nextPageUrl;
//     data['path'] = path;
//     data['per_page'] = perPage;
//     data['prev_page_url'] = prevPageUrl;
//     data['to'] = to;
//     data['total'] = total;
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? custId;
//   String? avtar;
//   String? name;
//   String? gender;
//   String? phoneNo;
//   String? relationshipId;
//   String? status;
//   String? timeOfBirth;
//   String? birthPlace;
//   String? dateOfAnniversary;
//   String? dateOfExpire;
//   String? dateOfTime;
//   String? dateOfPlace;
//   String? about;
//   String? education;
//   String? bloodGroupId;
//   String? panthId;
//   String? allowMatrimony;
//   String? naniyalGautraId;
//   String? dateOfBirth;
//   String? token;
//   String? createdAt;
//   String? updatedAt;
//   Panth? panth;
//   Panth? relationship;
//   Panth? bloodGroup;
//
//   Data(
//       {this.id,
//         this.custId,
//         this.avtar,
//         this.name,
//         this.gender,
//         this.phoneNo,
//         this.relationshipId,
//         this.status,
//         this.timeOfBirth,
//         this.birthPlace,
//         this.dateOfAnniversary,
//         this.dateOfExpire,
//         this.dateOfTime,
//         this.dateOfPlace,
//         this.about,
//         this.education,
//         this.bloodGroupId,
//         this.panthId,
//         this.allowMatrimony,
//         this.naniyalGautraId,
//         this.dateOfBirth,
//         this.token,
//         this.createdAt,
//         this.updatedAt,
//         this.panth,
//         this.relationship,
//         this.bloodGroup});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     custId = json['cust_id'];
//     avtar = json['avtar'];
//     name = json['name'];
//     gender = json['gender'];
//     phoneNo = json['phone_no'];
//     relationshipId = json['relationship_id'];
//     status = json['status'];
//     timeOfBirth = json['time_of_birth'];
//     birthPlace = json['birth_place'];
//     dateOfAnniversary = json['date_of_anniversary'];
//     dateOfExpire = json['date_of_expire'] ?? "";
//     dateOfTime = json['date_of_time'] ?? "";
//     dateOfPlace = json['date_of_place'] ?? "";
//     about = json['about'];
//     education = json['education'];
//     bloodGroupId = json['blood_group_id'];
//     panthId = json['panth_id'];
//     allowMatrimony = json['allow_matrimony'];
//     naniyalGautraId = json['naniyal_gautra_id'];
//     dateOfBirth = json['date_of_birth'];
//     token = json['token'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     panth = json['panth'] != null ? Panth.fromJson(json['panth']) : null;
//     relationship = json['relationship'] != null
//         ? Panth.fromJson(json['relationship'])
//         : null;
//     bloodGroup = json['blood_group'] != null
//         ? Panth.fromJson(json['blood_group'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['cust_id'] = custId;
//     data['avtar'] = avtar;
//     data['name'] = name;
//     data['gender'] = gender;
//     data['phone_no'] = phoneNo;
//     data['relationship_id'] = relationshipId;
//     data['status'] = status;
//     data['time_of_birth'] = timeOfBirth;
//     data['birth_place'] = birthPlace;
//     data['date_of_anniversary'] = dateOfAnniversary;
//     data['date_of_expire'] = dateOfExpire;
//     data['date_of_time'] = dateOfTime;
//     data['date_of_place'] = dateOfPlace;
//     data['about'] = about;
//     data['education'] = education;
//     data['blood_group_id'] = bloodGroupId;
//     data['panth_id'] = panthId;
//     data['allow_matrimony'] = allowMatrimony;
//     data['naniyal_gautra_id'] = naniyalGautraId;
//     data['date_of_birth'] = dateOfBirth;
//     data['token'] = token;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     if (panth != null) {
//       data['panth'] = panth!.toJson();
//     }
//     if (relationship != null) {
//       data['relationship'] = relationship!.toJson();
//     }
//     if (bloodGroup != null) {
//       data['blood_group'] = bloodGroup!.toJson();
//     }
//     return data;
//   }
// }
//
// class Panth {
//   int? id;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//
//   Panth({this.id, this.name, this.createdAt, this.updatedAt});
//
//   Panth.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
// }
//
// class Links {
//   String? url;
//   String? label;
//   bool? active;
//
//   Links({this.url, this.label, this.active});
//
//   Links.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     label = json['label'];
//     active = json['active'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['url'] = url;
//     data['label'] = label;
//     data['active'] = active;
//     return data;
//   }
// }

// To parse this JSON data, do
//
//     final matrimonyModel = matrimonyModelFromJson(jsonString);

import 'dart:convert';

MatrimonyModel matrimonyModelFromJson(String str) => MatrimonyModel.fromJson(json.decode(str));

String matrimonyModelToJson(MatrimonyModel data) => json.encode(data.toJson());

class MatrimonyModel {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  MatrimonyModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory MatrimonyModel.fromJson(Map<String, dynamic> json) => MatrimonyModel(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  int? id;
  String? custId;
  String? avtar;
  String? name;
  String? gender;
  String? phoneNo;
  String? relationshipId;
  String? status;
  String? timeOfBirth;
  String? birthPlace;
  String? dateOfAnniversary;
  dynamic dateOfExpire;
  dynamic dateOfTime;
  dynamic dateOfPlace;
  String? about;
  String? education;
  String? bloodGroupId;
  String? panthId;
  String? allowMatrimony;
  String? naniyalGautraId;
  String? dateOfBirth;
  String? token;
  String? createdAt;
  String? updatedAt;
  BloodGroup? panth;
  BloodGroup? relationship;
  BloodGroup? bloodGroup;
  Customer? customer;

  Datum({
    this.id,
    this.custId,
    this.avtar,
    this.name,
    this.gender,
    this.phoneNo,
    this.relationshipId,
    this.status,
    this.timeOfBirth,
    this.birthPlace,
    this.dateOfAnniversary,
    this.dateOfExpire,
    this.dateOfTime,
    this.dateOfPlace,
    this.about,
    this.education,
    this.bloodGroupId,
    this.panthId,
    this.allowMatrimony,
    this.naniyalGautraId,
    this.dateOfBirth,
    this.token,
    this.createdAt,
    this.updatedAt,
    this.panth,
    this.relationship,
    this.bloodGroup,
    this.customer,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    custId: json["cust_id"],
    avtar: json["avtar"],
    name: json["name"],
    gender: json["gender"],
    phoneNo: json["phone_no"],
    relationshipId: json["relationship_id"],
    status: json["status"],
    timeOfBirth: json["time_of_birth"],
    birthPlace: json["birth_place"],
    dateOfAnniversary: json["date_of_anniversary"],
    dateOfExpire: json["date_of_expire"],
    dateOfTime: json["date_of_time"],
    dateOfPlace: json["date_of_place"],
    about: json["about"],
    education: json["education"],
    bloodGroupId: json["blood_group_id"],
    panthId: json["panth_id"],
    allowMatrimony: json["allow_matrimony"],
    naniyalGautraId: json["naniyal_gautra_id"],
    dateOfBirth: json["date_of_birth"],
    token: json["token"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    panth: json["panth"] == null ? null : BloodGroup.fromJson(json["panth"]),
    relationship: json["relationship"] == null ? null : BloodGroup.fromJson(json["relationship"]),
    bloodGroup: json["blood_group"] == null ? null : BloodGroup.fromJson(json["blood_group"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cust_id": custId,
    "avtar": avtar,
    "name": name,
    "gender": gender,
    "phone_no": phoneNo,
    "relationship_id": relationshipId,
    "status": status,
    "time_of_birth": timeOfBirth,
    "birth_place": birthPlace,
    "date_of_anniversary": dateOfAnniversary,
    "date_of_expire": dateOfExpire,
    "date_of_time": dateOfTime,
    "date_of_place": dateOfPlace,
    "about": about,
    "education": education,
    "blood_group_id": bloodGroupId,
    "panth_id": panthId,
    "allow_matrimony": allowMatrimony,
    "naniyal_gautra_id": naniyalGautraId,
    "date_of_birth": dateOfBirth,
    "token": token,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "panth": panth?.toJson(),
    "relationship": relationship?.toJson(),
    "blood_group": bloodGroup?.toJson(),
    "customer": customer?.toJson(),
  };
}

class BloodGroup {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  BloodGroup({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory BloodGroup.fromJson(Map<String, dynamic> json) => BloodGroup(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Customer {
  int? id;
  String? avtarUrl;
  String? firstName;
  String? fatherHusbandName;
  String? surnameId;
  String? panthId;
  String? pattiId;
  String? dateOfBirth;
  String? gender;
  String? phoneNo;
  String? altPhoneNo;
  String? emailId;
  String? bloodGroupId;
  String? address;
  String? pincode;
  String? cityId;
  String? stateId;
  String? status;
  dynamic timeOfBirth;
  dynamic birthPlace;
  String? dateOfAnniversary;
  String? sasuralGautraId;
  dynamic dateOfExpired;
  String? education;
  String? nativeAddress;
  dynamic nativePincode;
  String? nativeStateId;
  String? nativeCityId;
  String? businessCategoryId;
  String? companyFirmName;
  String? businessDesignation;
  String? businessAddress;
  String? businessPincode;
  String? businessStateId;
  String? businessCityId;
  String? systemStatus;
  dynamic comment;
  String? otp;
  String? token;
  String? start;
  String? end;
  String? createdAt;
  String? updatedAt;

  Customer({
    this.id,
    this.avtarUrl,
    this.firstName,
    this.fatherHusbandName,
    this.surnameId,
    this.panthId,
    this.pattiId,
    this.dateOfBirth,
    this.gender,
    this.phoneNo,
    this.altPhoneNo,
    this.emailId,
    this.bloodGroupId,
    this.address,
    this.pincode,
    this.cityId,
    this.stateId,
    this.status,
    this.timeOfBirth,
    this.birthPlace,
    this.dateOfAnniversary,
    this.sasuralGautraId,
    this.dateOfExpired,
    this.education,
    this.nativeAddress,
    this.nativePincode,
    this.nativeStateId,
    this.nativeCityId,
    this.businessCategoryId,
    this.companyFirmName,
    this.businessDesignation,
    this.businessAddress,
    this.businessPincode,
    this.businessStateId,
    this.businessCityId,
    this.systemStatus,
    this.comment,
    this.otp,
    this.token,
    this.start,
    this.end,
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    avtarUrl: json["avtar_url"],
    firstName: json["first_name"],
    fatherHusbandName: json["father_husband_name"],
    surnameId: json["surname_id"],
    panthId: json["panth_id"],
    pattiId: json["patti_id"],
    dateOfBirth: json["date_of_birth"],
    gender: json["gender"],
    phoneNo: json["phone_no"],
    altPhoneNo: json["alt_phone_no"],
    emailId: json["email_id"],
    bloodGroupId: json["blood_group_id"],
    address: json["address"],
    pincode: json["pincode"],
    cityId: json["city_id"],
    stateId: json["state_id"],
    status: json["status"],
    timeOfBirth: json["time_of_birth"],
    birthPlace: json["birth_place"],
    dateOfAnniversary: json["date_of_anniversary"],
    sasuralGautraId: json["sasural_gautra_id"],
    dateOfExpired: json["date_of_expired"],
    education: json["education"],
    nativeAddress: json["native_address"],
    nativePincode: json["native_pincode"],
    nativeStateId: json["native_state_id"],
    nativeCityId: json["native_city_id"],
    businessCategoryId: json["business_category_id"],
    companyFirmName: json["company_firm_name"],
    businessDesignation: json["business_designation"],
    businessAddress: json["business_address"],
    businessPincode: json["business_pincode"],
    businessStateId: json["business_state_id"],
    businessCityId: json["business_city_id"],
    systemStatus: json["system_status"],
    comment: json["comment"],
    otp: json["otp"],
    token: json["token"],
    start: json["start"],
    end: json["end"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "avtar_url": avtarUrl,
    "first_name": firstName,
    "father_husband_name": fatherHusbandName,
    "surname_id": surnameId,
    "panth_id": panthId,
    "patti_id": pattiId,
    "date_of_birth": dateOfBirth,
    "gender": gender,
    "phone_no": phoneNo,
    "alt_phone_no": altPhoneNo,
    "email_id": emailId,
    "blood_group_id": bloodGroupId,
    "address": address,
    "pincode": pincode,
    "city_id": cityId,
    "state_id": stateId,
    "status": status,
    "time_of_birth": timeOfBirth,
    "birth_place": birthPlace,
    "date_of_anniversary": dateOfAnniversary,
    "sasural_gautra_id": sasuralGautraId,
    "date_of_expired": dateOfExpired,
    "education": education,
    "native_address": nativeAddress,
    "native_pincode": nativePincode,
    "native_state_id": nativeStateId,
    "native_city_id": nativeCityId,
    "business_category_id": businessCategoryId,
    "company_firm_name": companyFirmName,
    "business_designation": businessDesignation,
    "business_address": businessAddress,
    "business_pincode": businessPincode,
    "business_state_id": businessStateId,
    "business_city_id": businessCityId,
    "system_status": systemStatus,
    "comment": comment,
    "otp": otp,
    "token": token,
    "start": start,
    "end": end,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
