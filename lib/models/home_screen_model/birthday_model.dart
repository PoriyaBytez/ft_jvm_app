class BirthDayModel {
  int? id;
  String? firstName;
  String? phoneNo;
  String? dateOfBirth;
  String? avtarUrl;
  String? fatherHusbandName;
  String? surnameId;
  Surname? surname;

  BirthDayModel(
      {this.id,
      this.firstName,
      this.phoneNo,
      this.dateOfBirth,
      this.avtarUrl,
      this.fatherHusbandName,
      this.surnameId,
      this.surname});

  BirthDayModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    phoneNo = json['phone_no'];
    dateOfBirth = json['date_of_birth'];
    avtarUrl = json['avtar_url'];
    fatherHusbandName = json['father_husband_name'];
    surnameId = json['surname_id'];
    surname =
        json['surname'] != null ? new Surname.fromJson(json['surname']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['phone_no'] = this.phoneNo;
    data['date_of_birth'] = this.dateOfBirth;
    data['avtar_url'] = this.avtarUrl;
    data['father_husband_name'] = this.fatherHusbandName;
    data['surname_id'] = this.surnameId;
    if (this.surname != null) {
      data['surname'] = this.surname!.toJson();
    }
    return data;
  }
}

class Surname {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Surname({this.id, this.name, this.createdAt, this.updatedAt});

  Surname.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
