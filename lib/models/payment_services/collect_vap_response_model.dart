class CollectVpaResponseModel {
  String? message;
  CollectVpaModel? data;
  String? status;

  CollectVpaResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory CollectVpaResponseModel.fromJson(Map<String, dynamic> json) =>
      CollectVpaResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? null
            : CollectVpaModel.fromJson(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "status": status,
      };
}

class CollectVpaModel {
  String? id;
  String? orderId;
  String? groupId;
  String? status;
  String? txnId;
  String? description;
  double? amount;
  String? message;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? transactionDate;
  String? errorMessage;
  String? customerRefNo;

  CollectVpaModel({
    this.id,
    this.orderId,
    this.groupId,
    this.status,
    this.txnId,
    this.description,
    this.amount,
    this.message,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.transactionDate,
    this.errorMessage,
    this.customerRefNo,
  });

  factory CollectVpaModel.fromJson(Map<String, dynamic> json) =>
      CollectVpaModel(
        id: json["id"],
        orderId: json["orderId"],
        groupId: json["groupId"],
        status: json["status"],
        txnId: json["txnId"],
        description: json["description"],
        amount: json["amount"],
        message: json["message"],
        userId: json["userId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        transactionDate: json["transactionDate"] == null
            ? null
            : DateTime.parse(json["transactionDate"]),
        errorMessage: json["errorMessage"],
        customerRefNo: json["customerRefNo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderId": orderId,
        "groupId": groupId,
        "status": status,
        "txnId": txnId,
        "description": description,
        "amount": amount,
        "message": message,
        "userId": userId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "transactionDate": transactionDate?.toIso8601String(),
        "errorMessage": errorMessage,
        "customerRefNo": customerRefNo,
      };
}
