class CheckVpaResponseModel {
    String? message;
    CheckVpaModel? data;
    String? status;

    CheckVpaResponseModel({
        this.message,
        this.data,
        this.status,
    });

    factory CheckVpaResponseModel.fromJson(Map<String, dynamic> json) => CheckVpaResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : CheckVpaModel.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "status": status,
    };
}

class CheckVpaModel {
    String? code;
    String? description;

    CheckVpaModel({
        this.code,
        this.description,
    });

    factory CheckVpaModel.fromJson(Map<String, dynamic> json) => CheckVpaModel(
        code: json["code"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
    };
}
