// To parse this JSON data, do
//
//     final PunyaTithi = PunyaTithiFromJson(jsonString);

import 'dart:convert';

PunyaTithi PunyaTithiFromJson(String str) => PunyaTithi.fromJson(json.decode(str));

String PunyaTithiToJson(PunyaTithi data) => json.encode(data.toJson());

class PunyaTithi {
  List<Member>? members;

  PunyaTithi({
    this.members,
  });

  factory PunyaTithi.fromJson(Map<String, dynamic> json) => PunyaTithi(
    members: json["members"] == null ? [] : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x.toJson())),
  };
}

class Member {
  int? id;
  String? custId;
  String? avtar;
  String? name;
  String? gender;
  String? phoneNo;
  String? relationshipId;
  String? status;
  dynamic timeOfBirth;
  dynamic birthPlace;
  dynamic dateOfAnniversary;
  DateTime? dateOfExpire;
  dynamic dateOfTime;
  dynamic dateOfPlace;
  String? about;
  dynamic education;
  dynamic bloodGroupId;
  String? panthId;
  String? allowMatrimony;
  dynamic naniyalGautraId;
  dynamic dateOfBirth;
  String? token;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? cityId;
  int? yearsOfExpiry;

  Member({
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
    this.cityId,
    this.yearsOfExpiry,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
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
    dateOfExpire: json["date_of_expire"] == null ? null : DateTime.parse(json["date_of_expire"]),
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    cityId: json["city_id"],
    yearsOfExpiry: json["years_of_expiry"],
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
    "date_of_expire": "${dateOfExpire!.year.toString().padLeft(4, '0')}-${dateOfExpire!.month.toString().padLeft(2, '0')}-${dateOfExpire!.day.toString().padLeft(2, '0')}",
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "city_id": cityId,
    "years_of_expiry": yearsOfExpiry,
  };
}
