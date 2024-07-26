// To parse this JSON data, do
//
//     final showTeachersModel = showTeachersModelFromJson(jsonString);

import 'dart:convert';

ShowTeachersModel showTeachersModelFromJson(String str) =>
    ShowTeachersModel.fromJson(json.decode(str));

String showTeachersModelToJson(ShowTeachersModel data) =>
    json.encode(data.toJson());

class ShowTeachersModel {
  final bool? status;
  final String? message;
  final TeacherModel? data;

  ShowTeachersModel({
    this.status,
    this.message,
    this.data,
  });

  factory ShowTeachersModel.fromJson(Map<String, dynamic> json) =>
      ShowTeachersModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : TeacherModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

IndexTeachersModel indexTeachersModelFromJson(String str) =>
    IndexTeachersModel.fromJson(json.decode(str));

String indexTeachersModelToJson(IndexTeachersModel data) =>
    json.encode(data.toJson());

class IndexTeachersModel {
  final bool? status;
  final String? message;
  final List<TeacherModel>? data;

  IndexTeachersModel({
    this.status,
    this.message,
    this.data,
  });

  factory IndexTeachersModel.fromJson(Map<String, dynamic> json) =>
      IndexTeachersModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TeacherModel>.from(
                json["data"]!.map((x) => TeacherModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TeacherModel {
  final int? id;
  final String? name;
  final String? image;
  final String? phone;
  final String? specilty;
  final String? email;
  final String? description;
  final int? block;
  final int? accountId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TeacherModel({
    this.id,
    this.name,
    this.image,
    this.phone,
    this.specilty,
    this.email,
    this.description,
    this.block,
    this.accountId,
    this.createdAt,
    this.updatedAt,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        phone: json["phone"],
        specilty: json["specilty"],
        email: json["email"],
        description: json["description"],
        block: json["block"],
        accountId: json["account_id"],
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
        "image": image,
        "phone": phone,
        "specilty": specilty,
        "email": email,
        "description": description,
        "block": block,
        "account_id": accountId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  TeacherModel copyWith({
    int? id,
    String? name,
    String? image,
    String? phone,
    String? specilty,
    String? email,
    String? description,
    int? block,
    int? accountId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TeacherModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      specilty: specilty ?? this.specilty,
      email: email ?? this.email,
      description: description ?? this.description,
      block: block ?? this.block,
      accountId: accountId ?? this.accountId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
