// To parse this JSON data, do
//
//     final subjectsResponseModel = subjectsResponseModelFromJson(jsonString);
// To parse this JSON data, do
//
//     final showSubjectsResponseModel = showSubjectsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'lessons_model.dart';

ShowSubjectsResponseModel showSubjectsResponseModelFromJson(String str) =>
    ShowSubjectsResponseModel.fromJson(json.decode(str));

String showSubjectsResponseModelToJson(ShowSubjectsResponseModel data) =>
    json.encode(data.toJson());

class ShowSubjectsResponseModel {
  final bool? status;
  final String? message;
  final SubjectModel? data;

  ShowSubjectsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory ShowSubjectsResponseModel.fromJson(Map<String, dynamic> json) =>
      ShowSubjectsResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : SubjectModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class SubjectModel {
  final int? id;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<LessonModel>? lessons;

  SubjectModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.lessons,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        lessons: json["lessons"] == null
            ? []
            : List<LessonModel>.from(
                json["lessons"]!.map((x) => LessonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "lessons": lessons == null
            ? []
            : List<dynamic>.from(lessons!.map((x) => x.toJson())),
      };
}

SubjectsResponseModel subjectsResponseModelFromJson(String str) =>
    SubjectsResponseModel.fromJson(json.decode(str));

String subjectsResponseModelToJson(SubjectsResponseModel data) =>
    json.encode(data.toJson());

class SubjectsResponseModel {
  final bool? status;
  final String? message;
  final List<SubjectModel>? data;

  SubjectsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory SubjectsResponseModel.fromJson(Map<String, dynamic> json) =>
      SubjectsResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<SubjectModel>.from(
                json["data"]!.map((x) => SubjectModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
