// To parse this JSON data, do
//
//     final indexLessonsResponseModel = indexLessonsResponseModelFromJson(jsonString);

import 'dart:convert';

IndexLessonsResponseModel indexLessonsResponseModelFromJson(String str) =>
    IndexLessonsResponseModel.fromJson(json.decode(str));

String indexLessonsResponseModelToJson(IndexLessonsResponseModel data) =>
    json.encode(data.toJson());

ShowLessonsResponseModel showLessonsResponseModelFromJson(String str) =>
    ShowLessonsResponseModel.fromJson(json.decode(str));

String showLessonsResponseModelToJson(ShowLessonsResponseModel data) =>
    json.encode(data.toJson());

class ShowLessonsResponseModel {
  final bool? status;
  final String? message;
  final LessonModel? data;

  ShowLessonsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory ShowLessonsResponseModel.fromJson(Map<String, dynamic> json) =>
      ShowLessonsResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : LessonModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class LessonModel {
  final String? name;
  final String? description;
  final String? activity;
  final String? text;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final String? image;
  final int? subjectId;
  final Subject? subject;

  LessonModel({
    this.name,
    this.description,
    this.activity,
    this.text,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.image,
    this.subjectId,
    this.subject,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
        name: json["name"],
        description: json["description"],
        activity: json["activity"],
        text: json["text"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        image: json["image"],
        subjectId: json["subject_id"],
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "activity": activity,
        "text": text,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "image": image,
        "subject_id": subjectId,
        "subject": subject?.toJson(),
      };
}

class Subject {
  final int? id;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Subject({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
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

class IndexLessonsResponseModel {
  final bool? status;
  final String? message;
  final List<LessonModel>? data;

  IndexLessonsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory IndexLessonsResponseModel.fromJson(Map<String, dynamic> json) =>
      IndexLessonsResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<LessonModel>.from(
                json["data"]!.map((x) => LessonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
