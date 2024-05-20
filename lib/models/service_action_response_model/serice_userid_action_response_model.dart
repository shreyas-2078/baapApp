class ServiceActionByUserResponseModel {
    String? status;
    ServiceActionByUserModel? data;

    ServiceActionByUserResponseModel({
        this.status,
        this.data,
    });

    factory ServiceActionByUserResponseModel.fromJson(Map<String, dynamic> json) => ServiceActionByUserResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : ServiceActionByUserModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class ServiceActionByUserModel {
    int? phoneNumber;
    int? servicerequestId;
    Location? location;
    String? name;
    int? userId;
    int? groupId;
    String? status;
    int? serviceResponsesCount;
    int? handledById;
    String? locationName;
    int? locationPin;
    String? id;
    String? document;
    String? dateTime;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    ServiceActionByUserModel({
        this.phoneNumber,
        this.servicerequestId,
        this.location,
        this.name,
        this.userId,
        this.groupId,
        this.status,
        this.serviceResponsesCount,
        this.handledById,
        this.locationName,
        this.locationPin,
        this.id,
        this.document,
        this.dateTime,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory ServiceActionByUserModel.fromJson(Map<String, dynamic> json) => ServiceActionByUserModel(
        phoneNumber: json["phoneNumber"],
        servicerequestId: json["servicerequestId"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        name: json["name"],
        userId: json["userId"],
        groupId: json["groupId"],
        status: json["status"],
        serviceResponsesCount: json["serviceResponsesCount"],
        handledById: json["handledById"],
        locationName: json["locationName"],
        locationPin: json["locationPin"],
        id: json["_id"],
        document: json["document"],
        dateTime: json["DateTime"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "servicerequestId": servicerequestId,
        "location": location?.toJson(),
        "name": name,
        "userId": userId,
        "groupId": groupId,
        "status": status,
        "serviceResponsesCount": serviceResponsesCount,
        "handledById": handledById,
        "locationName": locationName,
        "locationPin": locationPin,
        "_id": id,
        "document": document,
        "DateTime": dateTime,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Location {
    List<double>? coordinates;
    String? type;

    Location({
        this.coordinates,
        this.type,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
        "type": type,
    };
}
