class FamilyMembersModel {
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
  String? dateOfExpire;
  String? dateOfTime;
  String? dateOfPlace;
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

  FamilyMembersModel(
      {this.id,
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
        this.updatedAt});

  FamilyMembersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    custId = json['cust_id'];
    avtar = json['avtar'];
    name = json['name'];
    gender = json['gender'];
    phoneNo = json['phone_no'];
    relationshipId = json['relationship_id'];
    status = json['status'];
    timeOfBirth = json['time_of_birth'] ?? "";
    birthPlace = json['birth_place'] ?? "";
    dateOfAnniversary = json['date_of_anniversary'];
    dateOfExpire = json['date_of_expire'];
    dateOfTime = json['date_of_time'] ?? "";
    dateOfPlace = json['date_of_place'] ?? "";
    about = json['about'];
    education = json['education'];
    bloodGroupId = json['blood_group_id'];
    panthId = json['panth_id'];
    allowMatrimony = json['allow_matrimony'];
    naniyalGautraId = json['naniyal_gautra_id'];
    dateOfBirth = json['date_of_birth'] ?? "";
    token = json['token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cust_id'] = custId;
    data['avtar'] = avtar;
    data['name'] = name;
    data['gender'] = gender;
    data['phone_no'] = phoneNo;
    data['relationship_id'] = relationshipId;
    data['status'] = status;
    data['time_of_birth'] = timeOfBirth;
    data['birth_place'] = birthPlace;
    data['date_of_anniversary'] = dateOfAnniversary;
    data['date_of_expire'] = dateOfExpire;
    data['date_of_time'] = dateOfTime;
    data['date_of_place'] = dateOfPlace;
    data['about'] = about;
    data['education'] = education;
    data['blood_group_id'] = bloodGroupId;
    data['panth_id'] = panthId;
    data['allow_matrimony'] = allowMatrimony;
    data['naniyal_gautra_id'] = naniyalGautraId;
    data['date_of_birth'] = dateOfBirth;
    data['token'] = token;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}