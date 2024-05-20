class CheckPaymentStatusResponseModel {
  String? message;
  CheckPaymentStatusModel? data;
  String? status;

  CheckPaymentStatusResponseModel({
    this.message,
    this.data,
    this.status,
  });

  factory CheckPaymentStatusResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckPaymentStatusResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? null
            : CheckPaymentStatusModel.fromJson(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "status": status,
      };
}

class CheckPaymentStatusModel {
  String? id;
  String? orderId;
  String? groupId;
  String? status;
  String? txnId;
  String? description;
  double? amount;
  dynamic message;
  dynamic userId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic transactionDate;
  dynamic errorMessage;

  CheckPaymentStatusModel({
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
  });

  factory CheckPaymentStatusModel.fromJson(Map<String, dynamic> json) =>
      CheckPaymentStatusModel(
        id: json["id"],
        orderId: json["orderId"],
        groupId: json["groupId"],
        status: json["status"],
        txnId: json["txnId"],
        description: json["description"],
        amount: json["amount"],
        message: json["message"],
        userId: json["userId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        transactionDate: json["transactionDate"],
        errorMessage: json["errorMessage"],
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
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "transactionDate": transactionDate,
        "errorMessage": errorMessage,
      };
}
