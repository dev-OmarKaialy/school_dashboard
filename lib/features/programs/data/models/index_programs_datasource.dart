// To parse this JSON data, do
//
//     final indexProgramsModel = indexProgramsModelFromJson(jsonString);

import 'dart:convert';

IndexProgramsModel indexProgramsModelFromJson(String str) =>
    IndexProgramsModel.fromJson(json.decode(str));

String indexProgramsModelToJson(IndexProgramsModel data) =>
    json.encode(data.toJson());

class IndexProgramsModel {
  final bool? status;
  final String? message;
  final List<ProgramModel>? data;

  IndexProgramsModel({
    this.status,
    this.message,
    this.data,
  });

  factory IndexProgramsModel.fromJson(Map<String, dynamic> json) =>
      IndexProgramsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ProgramModel>.from(
                json["data"]!.map((x) => ProgramModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProgramModel {
  final int? id;
  final String? name;
  final String? description;
  final int? typeSectionId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ProgramLesson>? programLesson;

  ProgramModel({
    this.id,
    this.name,
    this.description,
    this.typeSectionId,
    this.createdAt,
    this.updatedAt,
    this.programLesson,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) => ProgramModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        typeSectionId: json["type_section_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        programLesson: json["program_lesson"] == null
            ? []
            : List<ProgramLesson>.from(
                json["program_lesson"]!.map((x) => ProgramLesson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type_section_id": typeSectionId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "program_lesson": programLesson == null
            ? []
            : List<dynamic>.from(programLesson!.map((x) => x.toJson())),
      };
}

class ProgramLesson {
  final int? id;
  final int? lessonId;
  final int? programId;
  final int? teacherId;
  final String? time;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProgramLesson({
    this.id,
    this.lessonId,
    this.programId,
    this.teacherId,
    this.time,
    this.createdAt,
    this.updatedAt,
  });

  factory ProgramLesson.fromJson(Map<String, dynamic> json) => ProgramLesson(
        id: json["id"],
        lessonId: json["lesson_id"],
        programId: json["program_id"],
        teacherId: json["teacher_id"],
        time: json["time"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lesson_id": lessonId,
        "program_id": programId,
        "teacher_id": teacherId,
        "time": time,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
