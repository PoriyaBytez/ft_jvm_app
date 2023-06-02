class UserDataModel {
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
  String? timeOfBirth;
  String? birthPlace;
  String? dateOfAnniversary;
  String? sasuralGautraId;
  String? dateOfExpired;
  String? education;
  String? nativeAddress;
  String? nativePincode;
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
  String? comment;
  String? otp;
  String? token;
  String? start;
  String? end;
  String? createdAt;
  String? updatedAt;

  UserDataModel(
      {this.id,
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
        this.updatedAt});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avtarUrl = json['avtar_url'];
    firstName = json['first_name'];
    fatherHusbandName = json['father_husband_name'];
    surnameId = json['surname_id'];
    panthId = json['panth_id'];
    pattiId = json['patti_id'];
    dateOfBirth = json['date_of_birth'] ?? "";
    gender = json['gender'];
    phoneNo = json['phone_no'];
    altPhoneNo = json['alt_phone_no'] ?? "";
    emailId = json['email_id'] ?? "";
    bloodGroupId = json['blood_group_id'] ?? "";
    address = json['address'] ?? "";
    pincode = json['pincode'] ?? "";
    cityId = json['city_id'];
    stateId = json['state_id'];
    status = json['status'] ?? "";
    timeOfBirth = json['time_of_birth'] ?? "";
    birthPlace = json['birth_place'] ?? "";
    dateOfAnniversary = json['date_of_anniversary'] ?? "";
    sasuralGautraId = json['sasural_gautra_id'] ?? "";
    dateOfExpired = json['date_of_expired'] ?? "";
    education = json['education'] ?? "";
    nativeAddress = json['native_address'] ?? "";
    nativePincode = json['native_pincode'] ?? "";
    nativeStateId = json['native_state_id'] ?? "";
    nativeCityId = json['native_city_id'];
    businessCategoryId = json['business_category_id'] ?? "";
    companyFirmName = json['company_firm_name'] ?? "";
    businessDesignation = json['business_designation'] ?? "";
    businessAddress = json['business_address'] ?? "";
    businessPincode = json['business_pincode'] ?? "";
    businessStateId = json['business_state_id'] ?? "";
    businessCityId = json['business_city_id'] ?? "";
    systemStatus = json['system_status'];
    comment = json['comment'] ?? "";
    otp = json['otp'] ?? "";
    token = json['token'];
    start = json['start'] ?? "";
    end = json['end'] ?? "";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avtar_url'] = avtarUrl;
    data['first_name'] = firstName;
    data['father_husband_name'] = fatherHusbandName;
    data['surname_id'] = surnameId;
    data['panth_id'] = panthId;
    data['patti_id'] = pattiId;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['phone_no'] = phoneNo;
    data['alt_phone_no'] = altPhoneNo;
    data['email_id'] = emailId;
    data['blood_group_id'] = bloodGroupId;
    data['address'] = address;
    data['pincode'] = pincode;
    data['city_id'] = cityId;
    data['state_id'] = stateId;
    data['status'] = status;
    data['time_of_birth'] = timeOfBirth;
    data['birth_place'] = birthPlace;
    data['date_of_anniversary'] = dateOfAnniversary;
    data['sasural_gautra_id'] = sasuralGautraId;
    data['date_of_expired'] = dateOfExpired;
    data['education'] = education;
    data['native_address'] = nativeAddress;
    data['native_pincode'] = nativePincode;
    data['native_state_id'] = nativeStateId;
    data['native_city_id'] = nativeCityId;
    data['business_category_id'] = businessCategoryId;
    data['company_firm_name'] = companyFirmName;
    data['business_designation'] = businessDesignation;
    data['business_address'] = businessAddress;
    data['business_pincode'] = businessPincode;
    data['business_state_id'] = businessStateId;
    data['business_city_id'] = businessCityId;
    data['system_status'] = systemStatus;
    data['comment'] = comment;
    data['otp'] = otp;
    data['token'] = token;
    data['start'] = start;
    data['end'] = end;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}