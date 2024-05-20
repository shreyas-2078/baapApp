class RefreshTokenResponseModel {
  String? message;
  String? status;
  UserExitsModel? data;
  dynamic token;

  RefreshTokenResponseModel({
    this.message,
    this.data,
    this.status,
    this.token,
  });

  factory RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      RefreshTokenResponseModel(
        message: json["message"],
        data:
            json["data"] == null ? null : UserExitsModel.fromJson(json["data"]),
        status: json["status"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
        "token": token,
      };
}

class UserExitsModel {
  bool? userExists;
  bool? customerExists;
  bool? memberExists;

  UserExitsModel({
    this.userExists,
    this.customerExists,
    this.memberExists,
  });

  factory UserExitsModel.fromJson(Map<String, dynamic> json) => UserExitsModel(
        userExists: json["userExists"],
        customerExists: json["customerExists"],
        memberExists: json["memberExists"],
      );

  Map<String, dynamic> toJson() => {
        "userExists": userExists,
        "customerExists": customerExists,
        "memberExists": memberExists,
      };
}
