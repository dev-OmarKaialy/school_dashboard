// To parse this JSON data, do
//
//     final showSectionModel = showSectionModelFromJson(jsonString);

import 'dart:convert';

ShowSectionModel showSectionModelFromJson(String str) =>
    ShowSectionModel.fromJson(json.decode(str));

String showSectionModelToJson(ShowSectionModel data) =>
    json.encode(data.toJson());

class ShowSectionModel {
  final bool? status;
  final String? message;
  final SectionModel? data;

  ShowSectionModel({
    this.status,
    this.message,
    this.data,
  });

  factory ShowSectionModel.fromJson(Map<String, dynamic> json) =>
      ShowSectionModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : SectionModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

IndexSectionModel indexSectionModelFromJson(String str) =>
    IndexSectionModel.fromJson(json.decode(str));

String indexSectionModelToJson(IndexSectionModel data) =>
    json.encode(data.toJson());

class IndexSectionModel {
  final bool? status;
  final String? message;
  final List<SectionModel>? data;

  IndexSectionModel({
    this.status,
    this.message,
    this.data,
  });

  factory IndexSectionModel.fromJson(Map<String, dynamic> json) =>
      IndexSectionModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<SectionModel>.from(
                json["data"]!.map((x) => SectionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SectionModel {
  final int? id;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SectionModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
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
