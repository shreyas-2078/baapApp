class UpdateCartResponseModel {
    int? status;
    String? message;

    UpdateCartResponseModel({
        this.status,
        this.message,
    });

    factory UpdateCartResponseModel.fromJson(Map<String, dynamic> json) => UpdateCartResponseModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}