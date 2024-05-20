
class ServiceRequestResponseModel {
    String? status;
    List<MenuModel>? data;
    int? totalItemsCount;
    int? totalPages;

    ServiceRequestResponseModel({
        this.status,
        this.data,
        this.totalItemsCount,
        this.totalPages,
    });

    factory ServiceRequestResponseModel.fromJson(Map<String, dynamic> json) => ServiceRequestResponseModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<MenuModel>.from(json["data"]!.map((x) => MenuModel.fromJson(x))),
        totalItemsCount: json["totalItemsCount"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalItemsCount": totalItemsCount,
        "totalPages": totalPages,
    };
}

class MenuModel {
    String? id;
    int? phoneNumber;
    CategoryId? categoryId;
    SubcategoryId? subcategoryId;
    int? servicerequestId;
    Location? location;
    String? name;
    UserId? userId;
    int? groupId;
    String? status;
    int? serviceResponsesCount;
    int? handledById;
    String? locationName;
    int? locationPin;
    dynamic document;
    String? dateTime;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? title;

    MenuModel({
        this.id,
        this.phoneNumber,
        this.categoryId,
        this.subcategoryId,
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
        this.document,
        this.dateTime,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.title,
    });

    factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        id: json["_id"],
        phoneNumber: json["phoneNumber"],
        categoryId: json["categoryId"] == null ? null : CategoryId.fromJson(json["categoryId"]),
        subcategoryId: json["subcategoryId"] == null ? null : SubcategoryId.fromJson(json["subcategoryId"]),
        servicerequestId: json["servicerequestId"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        name: json["name"],
        userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
        groupId: json["groupId"],
        status: json["status"],
        serviceResponsesCount: json["serviceResponsesCount"],
        handledById: json["handledById"],
        locationName: json["locationName"],
        locationPin: json["locationPin"],
        document: json["document"],
        dateTime: json["DateTime"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "phoneNumber": phoneNumber,
        "categoryId": categoryId?.toJson(),
        "subcategoryId": subcategoryId?.toJson(),
        "servicerequestId": servicerequestId,
        "location": location?.toJson(),
        "name": name,
        "userId": userId?.toJson(),
        "groupId": groupId,
        "status": status,
        "serviceResponsesCount": serviceResponsesCount,
        "handledById": handledById,
        "locationName": locationName,
        "locationPin": locationPin,
        "document": document,
        "DateTime": dateTime,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "title": title,
    };
}

class CategoryId {
    dynamic categoryId;
    String? name;
    int? subcategory;

    CategoryId({
        this.categoryId,
        this.name,
        this.subcategory,
    });

    factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        categoryId: json["categoryId"],
        name: json["name"],
        subcategory: json["subcategory"],
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "name": name,
        "subcategory": subcategory,
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

class SubcategoryId {
    String? name;
    dynamic subcategoryId;
    dynamic categoryId;
    String? desc;

    SubcategoryId({
        this.name,
        this.subcategoryId,
        this.categoryId,
        this.desc,
    });

    factory SubcategoryId.fromJson(Map<String, dynamic> json) => SubcategoryId(
        name: json["name"],
        subcategoryId: json["subcategoryId"],
        categoryId: json["categoryId"],
        desc: json["desc"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "subcategoryId": subcategoryId,
        "categoryId": categoryId,
        "desc": desc,
    };
}

class UserId {
    int? phoneNumber;
    String? name;
    int? userId;
    List<Membership>? membership;

    UserId({
        this.phoneNumber,
        this.name,
        this.userId,
        this.membership,
    });

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        phoneNumber: json["phoneNumber"],
        name: json["name"],
        userId: json["userId"],
        membership: json["membership"] == null ? [] : List<Membership>.from(json["membership"]!.map((x) => Membership.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "name": name,
        "userId": userId,
        "membership": membership == null ? [] : List<dynamic>.from(membership!.map((x) => x.toJson())),
    };
}

class Membership {
    String? membershipPremium;
    String? startDate;
    String? endDate;
    String? id;
    int? totalRewardsEarned;
    int? smartCardId;
    int? membershipId;
    String? barcodeImageUrl;

    Membership({
        this.membershipPremium,
        this.startDate,
        this.endDate,
        this.id,
        this.totalRewardsEarned,
        this.smartCardId,
        this.membershipId,
        this.barcodeImageUrl,
    });

    factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        membershipPremium: json["membershipPremium"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        id: json["_id"],
        totalRewardsEarned: json["totalRewardsEarned"],
        smartCardId: json["smartCardId"],
        membershipId: json["membershipId"],
        barcodeImageUrl: json["barcodeImageURL"],
    );

    Map<String, dynamic> toJson() => {
        "membershipPremium": membershipPremium,
        "startDate": startDate,
        "endDate": endDate,
        "_id": id,
        "totalRewardsEarned": totalRewardsEarned,
        "smartCardId": smartCardId,
        "membershipId": membershipId,
        "barcodeImageURL": barcodeImageUrl,
    };
}
