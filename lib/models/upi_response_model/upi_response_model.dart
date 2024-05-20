class UpiResponseModel {
  String? status;
  String? message;
  List<UPIModel>? data;

  UpiResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory UpiResponseModel.fromJson(Map<String, dynamic> json) =>
      UpiResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<UPIModel>.from(
                json["data"]!.map((x) => UPIModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UPIModel {
  String? upi;

  UPIModel({
    this.upi,
  });

  factory UPIModel.fromJson(Map<String, dynamic> json) => UPIModel(
        upi: json["upi"],
      );

  Map<String, dynamic> toJson() => {
        "upi": upi,
      };
}
