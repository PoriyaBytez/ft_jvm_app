class BirthdayNewModel {
  int? id;
  String? custId;
  String? name;
  String? phoneNo;
  String? dateOfBirth;
  String? avtar;

  BirthdayNewModel(
      {this.id,
        this.custId,
        this.name,
        this.phoneNo,
        this.dateOfBirth,
        this.avtar});

  BirthdayNewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    custId = json['cust_id'];
    name = json['first_name'];
    phoneNo = json['phone_no'];
    dateOfBirth = json['date_of_birth'];
    avtar = json['avtar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cust_id'] = this.custId;
    data['first_name'] = this.name;
    data['phone_no'] = this.phoneNo;
    data['date_of_birth'] = this.dateOfBirth;
    data['avtar_url'] = this.avtar;
    return data;
  }
}
