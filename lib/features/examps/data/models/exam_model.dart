// To parse this JSON data, do
//
//     final indexExampsModel = indexExampsModelFromJson(jsonString);

import 'dart:convert';

IndexExampsModel indexExampsModelFromJson(String str) =>
    IndexExampsModel.fromJson(json.decode(str));

String indexExampsModelToJson(IndexExampsModel data) =>
    json.encode(data.toJson());

class IndexExampsModel {
  final bool? status;
  final String? message;
  final List<ExamModel>? data;

  IndexExampsModel({
    this.status,
    this.message,
    this.data,
  });

  factory IndexExampsModel.fromJson(Map<String, dynamic> json) =>
      IndexExampsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ExamModel>.from(
                json["data"]!.map((x) => ExamModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ExamModel {
  final int? id;
  final String? name;
  final DateTime? day;
  final String? time;
  final int? typeSectionId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ExamModel({
    this.id,
    this.name,
    this.day,
    this.time,
    this.typeSectionId,
    this.createdAt,
    this.updatedAt,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        id: json["id"],
        name: json["name"],
        day: json["day"] == null ? null : DateTime.parse(json["day"]),
        time: json["time"],
        typeSectionId: json["type_section_id"],
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
        "day":
            "${day!.year.toString().padLeft(4, '0')}-${day!.month.toString().padLeft(2, '0')}-${day!.day.toString().padLeft(2, '0')}",
        "time": time,
        "type_section_id": typeSectionId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
