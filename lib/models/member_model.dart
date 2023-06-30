// To parse this JSON data, do
//
//     final memberDetails = memberDetailsFromJson(jsonString);

import 'dart:convert';

// MemberDetails memberDetailsFromJson(String str) => MemberDetails.fromJson(json.decode(str));
//
// String memberDetailsToJson(MemberDetails data) => json.encode(data.toJson());
//
// class MemberDetails {
//   List<MemberDetails>? data;
//
//   MemberDetails({
//     this.data,
//   });
//
//   factory MemberDetails.fromJson(Map<String, dynamic> json) => MemberDetails(
//     data: json["data"] == null ? [] : List<MemberDetails>.from(json["data"]!.map((x) => MemberDetails.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }

class MemberDetails {
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
  dynamic altPhoneNo;
  dynamic emailId;
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
  dynamic nativeAddress;
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
  List<FamilyMember>? familyMembers;
  SurnameGautra? surnameGautra;
  NativeCity? nativeCity;

  MemberDetails({
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
    this.familyMembers,
    this.surnameGautra,
    this.nativeCity,
  });

  factory MemberDetails.fromJson(Map<String, dynamic> json) => MemberDetails(
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
    familyMembers: json["family_members"] == null ? [] : List<FamilyMember>.from(json["family_members"]!.map((x) => FamilyMember.fromJson(x))),
    surnameGautra: json["surname_gautra"] == null ? null : SurnameGautra.fromJson(json["surname_gautra"]),
    nativeCity: json["native_city"] == null ? null : NativeCity.fromJson(json["native_city"]),
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
    "family_members": familyMembers == null ? [] : List<dynamic>.from(familyMembers!.map((x) => x.toJson())),
    "surname_gautra": surnameGautra?.toJson(),
    "native_city": nativeCity?.toJson(),
  };
}

class FamilyMember {
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
  String? dateOfAnniversary;
  String? dateOfExpire;
  dynamic dateOfTime;
  dynamic dateOfPlace;
  String? about;
  dynamic education;
  String? bloodGroupId;
  String? panthId;
  String? allowMatrimony;
  dynamic naniyalGautraId;
  String? dateOfBirth;
  String? token;
  String? createdAt;
  String? updatedAt;

  FamilyMember({
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
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) => FamilyMember(
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
  };
}

class NativeCity {
  int? id;
  String? city;
  String? stateId;
  String? updatedAt;
  String? createdAt;

  NativeCity({
    this.id,
    this.city,
    this.stateId,
    this.updatedAt,
    this.createdAt,
  });

  factory NativeCity.fromJson(Map<String, dynamic> json) => NativeCity(
    id: json["id"],
    city: json["city"],
    stateId: json["state_id"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "state_id": stateId,
    "updated_at": updatedAt,
    "created_at": createdAt,
  };
}

class SurnameGautra {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  SurnameGautra({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory SurnameGautra.fromJson(Map<String, dynamic> json) => SurnameGautra(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
