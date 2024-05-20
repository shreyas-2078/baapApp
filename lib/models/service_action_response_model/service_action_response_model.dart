class ServiceActionResponseModel {
    String? status;
    Data? data;

    ServiceActionResponseModel({
        this.status,
        this.data,
    });

    factory ServiceActionResponseModel.fromJson(Map<String, dynamic> json) => ServiceActionResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    int? groupId;
    int? subcategoryId;
    int? userId;

    Data({
        this.groupId,
        this.subcategoryId,
        this.userId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        groupId: json["groupId"],
        subcategoryId: json["subcategoryId"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "subcategoryId": subcategoryId,
        "userId": userId,
    };
}
