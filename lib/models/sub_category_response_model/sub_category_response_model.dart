
class SubCategoryResponseModel {
    String? status;
    Data? data;

    SubCategoryResponseModel({
        this.status,
        this.data,
    });

    factory SubCategoryResponseModel.fromJson(Map<String, dynamic> json) => SubCategoryResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    List<SubCategoryModel>? items;
    int? totalItemsCount;

    Data({
        this.items,
        this.totalItemsCount,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null ? [] : List<SubCategoryModel>.from(json["items"]!.map((x) => SubCategoryModel.fromJson(x))),
        totalItemsCount: json["totalItemsCount"],
    );

    Map<String, dynamic> toJson() => {
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalItemsCount": totalItemsCount,
    };
}

class SubCategoryModel {
    Location? location;
    String? id;
    String? name;
    int? groupId;
    int? subcategoryId;
    List<String>? tags;
    String? desc;
    dynamic icon;
    String? action;
    List<String>? productSearchTags;
    String? webpageUrl;
    List<int>? listener;
    bool? isFeatured;
    bool? messageCustomers;
    bool? paymentEnabled;
    bool? needCloseConfirmation;
    String? template;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    int? categoryId;
    Theme? theme;
    int? subGroupId;

    SubCategoryModel({
        this.location,
        this.id,
        this.name,
        this.groupId,
        this.subcategoryId,
        this.tags,
        this.desc,
        this.icon,
        this.action,
        this.productSearchTags,
        this.webpageUrl,
        this.listener,
        this.isFeatured,
        this.messageCustomers,
        this.paymentEnabled,
        this.needCloseConfirmation,
        this.template,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.categoryId,
        this.theme,
        this.subGroupId,
    });

    factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        id: json["_id"],
        name: json["name"],
        groupId: json["groupId"],
        subcategoryId: json["subcategoryId"],
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
        desc: json["desc"],
        icon: json["icon"],
        action: json["action"],
        productSearchTags: json["productSearchTags"] == null ? [] : List<String>.from(json["productSearchTags"]!.map((x) => x)),
        webpageUrl: json["webpageUrl"],
        listener: json["listener"] == null ? [] : List<int>.from(json["listener"]!.map((x) => x)),
        isFeatured: json["isFeatured"],
        messageCustomers: json["messageCustomers"],
        paymentEnabled: json["paymentEnabled"],
        needCloseConfirmation: json["needCloseConfirmation"],
        template: json["template"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        categoryId: json["categoryId"],
        theme: json["theme"] == null ? null : Theme.fromJson(json["theme"]),
        subGroupId: json["subGroupId"],
    );

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "name": name,
        "groupId": groupId,
        "subcategoryId": subcategoryId,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "desc": desc,
        "icon": icon,
        "action": action,
        "productSearchTags": productSearchTags == null ? [] : List<dynamic>.from(productSearchTags!.map((x) => x)),
        "webpageUrl": webpageUrl,
        "listener": listener == null ? [] : List<dynamic>.from(listener!.map((x) => x)),
        "isFeatured": isFeatured,
        "messageCustomers": messageCustomers,
        "paymentEnabled": paymentEnabled,
        "needCloseConfirmation": needCloseConfirmation,
        "template": template,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "categoryId": categoryId,
        "theme": theme?.toJson(),
        "subGroupId": subGroupId,
    };
}

class Location {
    String? type;
    List<double>? coordinates;

    Location({
        this.type,
        this.coordinates,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    };
}

class Theme {
    String? background;
    String? color;
    String? cover;

    Theme({
        this.background,
        this.color,
        this.cover,
    });

    factory Theme.fromJson(Map<String, dynamic> json) => Theme(
        background: json["background"],
        color: json["color"],
        cover: json["cover"],
    );

    Map<String, dynamic> toJson() => {
        "background": background,
        "color": color,
        "cover": cover,
    };
}
