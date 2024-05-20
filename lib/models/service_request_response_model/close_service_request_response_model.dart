
class CloseServiceRequestResponseModel {
    String? status;
    Data? data;

    CloseServiceRequestResponseModel({
        this.status,
        this.data,
    });

    factory CloseServiceRequestResponseModel.fromJson(Map<String, dynamic> json) => CloseServiceRequestResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    Location? location;
    String? id;
    int? phoneNumber;
    int? categoryId;
    int? subcategoryId;
    int? servicerequestId;
    String? name;
    int? userId;
    int? groupId;
    String? status;
    int? serviceResponsesCount;
    dynamic document;
    String? dateTime;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Data({
        this.location,
        this.id,
        this.phoneNumber,
        this.categoryId,
        this.subcategoryId,
        this.servicerequestId,
        this.name,
        this.userId,
        this.groupId,
        this.status,
        this.serviceResponsesCount,
        this.document,
        this.dateTime,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        id: json["_id"],
        phoneNumber: json["phoneNumber"],
        categoryId: json["categoryId"],
        subcategoryId: json["subcategoryId"],
        servicerequestId: json["servicerequestId"],
        name: json["name"],
        userId: json["userId"],
        groupId: json["groupId"],
        status: json["status"],
        serviceResponsesCount: json["serviceResponsesCount"],
        document: json["document"],
        dateTime: json["DateTime"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "phoneNumber": phoneNumber,
        "categoryId": categoryId,
        "subcategoryId": subcategoryId,
        "servicerequestId": servicerequestId,
        "name": name,
        "userId": userId,
        "groupId": groupId,
        "status": status,
        "serviceResponsesCount": serviceResponsesCount,
        "document": document,
        "DateTime": dateTime,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Location {
    String? type;
    List<dynamic>? coordinates;

    Location({
        this.type,
        this.coordinates,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: json["coordinates"] == null ? [] : List<dynamic>.from(json["coordinates"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    };
}
