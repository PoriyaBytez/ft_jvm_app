class MatrimonyModel {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  MatrimonyModel(
      {this.currentPage,
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
        this.total});

  MatrimonyModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'] ?? "";
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'] ?? "";
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
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
  Panth? panth;
  Panth? relationship;
  Panth? bloodGroup;

  Data(
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
        this.updatedAt,
        this.panth,
        this.relationship,
        this.bloodGroup});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    custId = json['cust_id'];
    avtar = json['avtar'];
    name = json['name'];
    gender = json['gender'];
    phoneNo = json['phone_no'];
    relationshipId = json['relationship_id'];
    status = json['status'];
    timeOfBirth = json['time_of_birth'];
    birthPlace = json['birth_place'];
    dateOfAnniversary = json['date_of_anniversary'];
    dateOfExpire = json['date_of_expire'] ?? "";
    dateOfTime = json['date_of_time'] ?? "";
    dateOfPlace = json['date_of_place'] ?? "";
    about = json['about'];
    education = json['education'];
    bloodGroupId = json['blood_group_id'];
    panthId = json['panth_id'];
    allowMatrimony = json['allow_matrimony'];
    naniyalGautraId = json['naniyal_gautra_id'];
    dateOfBirth = json['date_of_birth'];
    token = json['token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    panth = json['panth'] != null ? Panth.fromJson(json['panth']) : null;
    relationship = json['relationship'] != null
        ? Panth.fromJson(json['relationship'])
        : null;
    bloodGroup = json['blood_group'] != null
        ? Panth.fromJson(json['blood_group'])
        : null;
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
    if (this.panth != null) {
      data['panth'] = this.panth!.toJson();
    }
    if (this.relationship != null) {
      data['relationship'] = this.relationship!.toJson();
    }
    if (this.bloodGroup != null) {
      data['blood_group'] = this.bloodGroup!.toJson();
    }
    return data;
  }
}

class Panth {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Panth({this.id, this.name, this.createdAt, this.updatedAt});

  Panth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}