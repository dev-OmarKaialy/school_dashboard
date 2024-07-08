// To parse this JSON data, do
//
//     final indexTypesResponseModel = indexTypesResponseModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final showTypesResponseModel = showTypesResponseModelFromJson(jsonString);

import 'dart:convert';

ShowTypesResponseModel showTypesResponseModelFromJson(String str) =>
    ShowTypesResponseModel.fromJson(json.decode(str));

String showTypesResponseModelToJson(ShowTypesResponseModel data) =>
    json.encode(data.toJson());

class ShowTypesResponseModel {
  final bool? status;
  final String? message;
  final TypeModel? data;

  ShowTypesResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory ShowTypesResponseModel.fromJson(Map<String, dynamic> json) =>
      ShowTypesResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : TypeModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

IndexTypesResponseModel indexTypesResponseModelFromJson(String str) =>
    IndexTypesResponseModel.fromJson(json.decode(str));

String indexTypesResponseModelToJson(IndexTypesResponseModel data) =>
    json.encode(data.toJson());

class IndexTypesResponseModel {
  final bool? status;
  final String? message;
  final List<TypeModel>? data;

  IndexTypesResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory IndexTypesResponseModel.fromJson(Map<String, dynamic> json) =>
      IndexTypesResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TypeModel>.from(
                json["data"]!.map((x) => TypeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

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
        totalAmount: json["total_amount"].toString(),
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
