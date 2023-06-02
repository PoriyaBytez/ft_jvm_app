class AnniversaryModel {
  int? id;
  String? avtar;
  String? custId;
  String? gender;
  String? phoneNo;
  String? dateOfAnniversary;
  String? name;

  AnniversaryModel(
      {this.id,
        this.avtar,
        this.custId,
        this.gender,
        this.phoneNo,
        this.dateOfAnniversary,
        this.name});

  AnniversaryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avtar = json['avtar_url'];
    custId = json['cust_id'];
    gender = json['gender'];
    phoneNo = json['phone_no'];
    dateOfAnniversary = json['date_of_anniversary'];
    name = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avtar_url'] = avtar;
    data['cust_id'] = custId;
    data['gender'] = gender;
    data['phone_no'] = phoneNo;
    data['date_of_anniversary'] = dateOfAnniversary;
    data['first_name'] = name;
    return data;
  }
}