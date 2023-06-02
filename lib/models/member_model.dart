// To parse this JSON data, do
//
//     final getMember = getMemberFromJson(jsonString);

import 'dart:convert';

GetMember getMemberFromJson(String str) => GetMember.fromJson(json.decode(str));

String getMemberToJson(GetMember data) => json.encode(data.toJson());

// class GetMember {
//   List<Datum>? data;
//
//   GetMember({
//     this.data,
//   });
//
//   factory GetMember.fromJson(Map<String, dynamic> json) => GetMember(
//     data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }

class GetMember {
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
  dynamic bloodGroupId;
  dynamic address;
  dynamic pincode;
  String? cityId;
  String? stateId;
  String? status;
  dynamic timeOfBirth;
  dynamic birthPlace;
  String? dateOfAnniversary;
  dynamic sasuralGautraId;
  String? dateOfExpired;
  dynamic education;
  dynamic nativeAddress;
  dynamic nativePincode;
  dynamic nativeStateId;
  String? nativeCityId;
  dynamic businessCategoryId;
  dynamic companyFirmName;
  dynamic businessDesignation;
  dynamic businessAddress;
  dynamic businessPincode;
  dynamic businessStateId;
  dynamic businessCityId;
  String? systemStatus;
  dynamic comment;
  String? otp;
  dynamic token;
  String? start;
  String? end;
  String? createdAt;
  String? updatedAt;

  GetMember({
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

  GetMember.fromJson(Map<String, dynamic> json) {
    id= json["id"];
    avtarUrl= json["avtar_url"];
    firstName= json["first_name"];
    fatherHusbandName= json["father_husband_name"];
    surnameId= json["surname_id"];
    panthId= json["panth_id"];
    pattiId= json["patti_id"];
    dateOfBirth= json["date_of_birth"];
    gender= json["gender"];
    phoneNo= json["phone_no"];
    altPhoneNo= json["alt_phone_no"];
    emailId= json["email_id"];
    bloodGroupId= json["blood_group_id"];
    address= json["address"];
    pincode= json["pincode"];
    cityId= json["city_id"];
    stateId= json["state_id"];
    status= json["status"];
    timeOfBirth= json["time_of_birth"];
    birthPlace= json["birth_place"];
    dateOfAnniversary= json["date_of_anniversary"];
    sasuralGautraId= json["sasural_gautra_id"];
    dateOfExpired= json["date_of_expired"];
    education= json["education"];
    nativeAddress= json["native_address"];
    nativePincode= json["native_pincode"];
    nativeStateId= json["native_state_id"];
    nativeCityId= json["native_city_id"];
    businessCategoryId= json["business_category_id"];
    companyFirmName= json["company_firm_name"];
    businessDesignation= json["business_designation"];
    businessAddress= json["business_address"];
    businessPincode= json["business_pincode"];
    businessStateId= json["business_state_id"];
    businessCityId= json["business_city_id"];
    systemStatus= json["system_status"];
    comment= json["comment"];
    otp= json["otp"];
    token= json["token"];
    start= json["start"];
    end= json["end"];
    createdAt= json["created_at"];
    updatedAt= json["updated_at"];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "avtar_url": avtarUrl,
    "first_name": firstName,
    "father_husband_name": fatherHusbandName,
    "surname_id": surnameId,
    "panth_id": panthId,
    "patti_id": pattiId,
    "date_of_birth": "$dateOfBirth",
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
