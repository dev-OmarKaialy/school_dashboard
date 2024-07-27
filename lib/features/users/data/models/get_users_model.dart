// To parse this JSON data, do
//
//     final indexUsersModel = indexUsersModelFromJson(jsonString);

import 'dart:convert';

IndexUsersModel indexUsersModelFromJson(String str) =>
    IndexUsersModel.fromJson(json.decode(str));

String indexUsersModelToJson(IndexUsersModel data) =>
    json.encode(data.toJson());

class IndexUsersModel {
  final bool? status;
  final String? message;
  final List<UserModel>? data;

  IndexUsersModel({
    this.status,
    this.message,
    this.data,
  });

  factory IndexUsersModel.fromJson(Map<String, dynamic> json) =>
      IndexUsersModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<UserModel>.from(
                json["data"]!.map((x) => UserModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UserModel {
  final int? id;
  final String? image;
  final String? phone;
  final int? block;
  final int? grading;
  final String? address;
  final dynamic fcmToken;
  final int? accountId;
  final String? className;
  final dynamic typeSectionId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.id,
    this.image,
    this.phone,
    this.block,
    this.grading,
    this.address,
    this.fcmToken,
    this.accountId,
    this.className,
    this.typeSectionId,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        image: json["image"],
        phone: json["phone"],
        block: json["block"],
        grading: json["grading"],
        address: json["address"],
        fcmToken: json["fcm_token"],
        accountId: json["account_id"],
        className: json["class_name"],
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
        "image": image,
        "phone": phone,
        "block": block,
        "grading": grading,
        "address": address,
        "fcm_token": fcmToken,
        "account_id": accountId,
        "class_name": className,
        "type_section_id": typeSectionId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  UserModel copyWith({
    int? id,
    String? image,
    String? phone,
    int? block,
    int? grading,
    String? address,
    dynamic fcmToken,
    int? accountId,
    String? className,
    dynamic typeSectionId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      block: block ?? this.block,
      grading: grading ?? this.grading,
      address: address ?? this.address,
      fcmToken: fcmToken ?? this.fcmToken,
      accountId: accountId ?? this.accountId,
      className: className ?? this.className,
      typeSectionId: typeSectionId ?? this.typeSectionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
