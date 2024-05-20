class VerificationResponseModel {
  String? status;
  Data? data;
  String? message;
  String? token;

  VerificationResponseModel({
    this.status,
    this.data,
    this.message,
    this.token,
  });

  factory VerificationResponseModel.fromJson(Map<String, dynamic> json) =>
      VerificationResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
        "token": token,
      };
}

class Data {
  bool? userExists;

  Data({
    this.userExists,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userExists: json["userExists"],
      );

  Map<String, dynamic> toJson() => {
        "userExists": userExists,
      };
}
