// To parse this JSON data, do
//
//     final subjectResponseModel = subjectResponseModelFromJson(jsonString);

import 'dart:convert';

List<SubjectResponseModel> subjectResponseModelFromJson(String str) =>
    List<SubjectResponseModel>.from(
        json.decode(str).map((x) => SubjectResponseModel.fromJson(x)));

String subjectResponseModelToJson(List<SubjectResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectResponseModel {
  final int? id;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SubjectResponseModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory SubjectResponseModel.fromJson(Map<String, dynamic> json) =>
      SubjectResponseModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
