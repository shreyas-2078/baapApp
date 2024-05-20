// To parse this JSON data, do
//
//     final saveUserResponseModel = saveUserResponseModelFromJson(jsonString);

import 'dart:convert';

SaveUserResponseModel saveUserResponseModelFromJson(String str) => SaveUserResponseModel.fromJson(json.decode(str));

String saveUserResponseModelToJson(SaveUserResponseModel data) => json.encode(data.toJson());

class SaveUserResponseModel {
    Member? member;
    User? user;

    SaveUserResponseModel({
        this.member,
        this.user,
    });

    factory SaveUserResponseModel.fromJson(Map<String, dynamic> json) => SaveUserResponseModel(
        member: json["member"] == null ? null : Member.fromJson(json["member"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "member": member?.toJson(),
        "user": user?.toJson(),
    };
}

class Member {
    int? groupId;
    int? phoneNumber;
    int? custId;
    String? id;
    String? password;
    String? name;
    List<dynamic>? addresses;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    int? userId;

    Member({
        this.groupId,
        this.phoneNumber,
        this.custId,
        this.id,
        this.password,
        this.name,
        this.addresses,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.userId,
    });

    factory Member.fromJson(Map<String, dynamic> json) => Member(
        groupId: json["groupId"],
        phoneNumber: json["phoneNumber"],
        custId: json["custId"],
        id: json["_id"],
        password: json["password"],
        name: json["name"],
        addresses: json["addresses"] == null ? [] : List<dynamic>.from(json["addresses"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "phoneNumber": phoneNumber,
        "custId": custId,
        "_id": id,
        "password": password,
        "name": name,
        "addresses": addresses == null ? [] : List<dynamic>.from(addresses!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "userId": userId,
    };
}

class User {
    String? status;
    Data? data;
    String? token;

    User({
        this.status,
        this.data,
        this.token,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "token": token,
    };
}

class Data {
    String? name;
    int? userId;
    dynamic password;
    String? phoneNumber;
    String? id;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Data({
        this.name,
        this.userId,
        this.password,
        this.phoneNumber,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        userId: json["userId"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        id: json["_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "userId": userId,
        "password": password,
        "phoneNumber": phoneNumber,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
