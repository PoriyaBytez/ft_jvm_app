// To parse this JSON data, do
//
//     final utilitiesSubCategory = utilitiesSubCategoryFromJson(jsonString);

import 'dart:convert';

List<UtilitiesSubCategory> utilitiesSubCategoryFromJson(String str) => List<UtilitiesSubCategory>.from(json.decode(str).map((x) => UtilitiesSubCategory.fromJson(x)));

String utilitiesSubCategoryToJson(List<UtilitiesSubCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UtilitiesSubCategory {
  int? id;
  String? parentId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  UtilitiesSubCategory({
    this.id,
    this.parentId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory UtilitiesSubCategory.fromJson(Map<String, dynamic> json) => UtilitiesSubCategory(
    id: json["id"],
    parentId: json["parent_id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
