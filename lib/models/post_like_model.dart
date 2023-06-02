// To parse this JSON data, do
//
//     final postLike = postLikeFromJson(jsonString);

import 'dart:convert';

PostLike postLikeFromJson(String str) => PostLike.fromJson(json.decode(str));

String postLikeToJson(PostLike data) => json.encode(data.toJson());

class PostLike {
  List<Datum>? data;
  int? count;

  PostLike({
    this.data,
    this.count,
  });

  factory PostLike.fromJson(Map<String, dynamic> json) => PostLike(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "count": count,
  };
}

class Datum {
  int? id;
  String? customerId;
  String? postId;
  String? isLike;
  String? date;

  Datum({
    this.id,
    this.customerId,
    this.postId,
    this.isLike,
    this.date,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    customerId: json["customer_id"],
    postId: json["post_id"],
    isLike: json["is_like"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "post_id": postId,
    "is_like": isLike,
    "date": date,
  };
}
