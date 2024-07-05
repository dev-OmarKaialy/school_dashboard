// To parse this JSON data, do
//
//     final indexTypesResponseModel = indexTypesResponseModelFromJson(jsonString);

import 'dart:convert';

List<TypeModel> indexTypesResponseModelFromJson(String str) =>
    List<TypeModel>.from(json.decode(str).map((x) => TypeModel.fromJson(x)));

String indexTypesResponseModelToJson(List<TypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TypeModel {
  final int? id;
  final String? name;
  final String? description;
  final String? totalAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic>? sections;

  TypeModel({
    this.id,
    this.name,
    this.description,
    this.totalAmount,
    this.createdAt,
    this.updatedAt,
    this.sections,
  });

  factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        totalAmount: json["total_amount"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        sections: json["sections"] == null
            ? []
            : List<dynamic>.from(json["sections"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "total_amount": totalAmount,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "sections":
            sections == null ? [] : List<dynamic>.from(sections!.map((x) => x)),
      };
}
