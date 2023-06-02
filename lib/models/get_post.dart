class PostByIdModel {
  List<Posts>? posts = [];

  PostByIdModel({this.posts});

  PostByIdModel.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  int? id;
  String? postUrl;
  String? type;
  String? description;
  String? isApproved;
  Null? comment;
  String? isActive;
  String? customerId;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? avtarUrl;
  bool likeButtonClick = false;
  String? postLike;
  String? count;
  Posts(
      {this.id,
        this.postUrl,
        this.type,
        this.description,
        this.isApproved,
        this.comment,
        this.isActive,
        this.customerId,
        this.createdAt,
        this.updatedAt,
        this.firstName,
        this.avtarUrl,
        this.likeButtonClick = false,
      this.postLike,
      this.count});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postUrl = json['post_url'];
    type = json['type'];
    description = json['description'];
    isApproved = json['is_approved'];
    comment = json['comment'];
    isActive = json['is_active'];
    customerId = json['customer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json["first_name"];
    avtarUrl = json["avtar_url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['post_url'] = postUrl;
    data['type'] = type;
    data['description'] = description;
    data['is_approved'] = isApproved;
    data['comment'] = comment;
    data['is_active'] = isActive;
    data['customer_id'] = customerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['first_name'] = firstName;
    data['avtar_url'] = avtarUrl;
    return data;
  }
}
