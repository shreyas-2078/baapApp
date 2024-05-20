
class ServiceRequestDetailResponseModel {
    String? status;
    Data? data;

    ServiceRequestDetailResponseModel({
        this.status,
        this.data,
    });

    factory ServiceRequestDetailResponseModel.fromJson(Map<String, dynamic> json) => ServiceRequestDetailResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    List<ServiceDetailModel>? items;
    int? totalItemsCount;

    Data({
        this.items,
        this.totalItemsCount,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null ? [] : List<ServiceDetailModel>.from(json["items"]!.map((x) => ServiceDetailModel.fromJson(x))),
        totalItemsCount: json["totalItemsCount"],
    );

    Map<String, dynamic> toJson() => {
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalItemsCount": totalItemsCount,
    };
}

class ServiceDetailModel {
    String? id;
    int? servicerequestId;
    int? handledById;
    int? groupId;
    String? comments;
    String? handledBy;
    String? customerName;
    DateTime? dateTime;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? oldStatus;
    String? newStatus;
    dynamic targetEndDate;
    dynamic startDate;

    ServiceDetailModel({
        this.id,
        this.servicerequestId,
        this.handledById,
        this.groupId,
        this.comments,
        this.handledBy,
        this.customerName,
        this.dateTime,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.oldStatus,
        this.newStatus,
        this.targetEndDate,
        this.startDate,
    });

    factory ServiceDetailModel.fromJson(Map<String, dynamic> json) => ServiceDetailModel(
        id: json["_id"],
        servicerequestId: json["servicerequestId"],
        handledById: json["handledById"],
        groupId: json["groupId"],
        comments: json["comments"],
        handledBy: json["handledBy"],
        customerName: json["customerName"],
        dateTime: json["DateTime"] == null ? null : DateTime.parse(json["DateTime"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        oldStatus: json["oldStatus"],
        newStatus: json["newStatus"],
        targetEndDate: json["targetEndDate"],
        startDate: json["startDate"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "servicerequestId": servicerequestId,
        "handledById": handledById,
        "groupId": groupId,
        "comments": comments,
        "handledBy": handledBy,
        "customerName": customerName,
        "DateTime": dateTime?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "oldStatus": oldStatus,
        "newStatus": newStatus,
        "targetEndDate": targetEndDate,
        "startDate": startDate,
    };
}
