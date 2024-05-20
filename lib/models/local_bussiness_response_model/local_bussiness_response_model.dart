class LocalBussinessResponseModel {
  String? status;
  Data? data;

  LocalBussinessResponseModel({
    this.status,
    this.data,
  });

  factory LocalBussinessResponseModel.fromJson(Map<String, dynamic> json) =>
      LocalBussinessResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  List<LocalBussinessModel>? items;
  int? totalItemsCount;

  Data({
    this.items,
    this.totalItemsCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null
            ? []
            : List<LocalBussinessModel>.from(
                json["items"]!.map((x) => LocalBussinessModel.fromJson(x))),
        totalItemsCount: json["totalItemsCount"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalItemsCount": totalItemsCount,
      };
}

class LocalBussinessModel {
  Location? location;
  bool? featured;
  bool? promotion;
  bool? sponsored;
  String? id;
  int? groupId;
  int? categoryId;
  String? name;
  int? subGroupId;
  String? desc;
  List<String>? tags;
  String? action;
  List<int>? listener;
  Theme? theme;
  String? icon;
  String? template;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? parentId;
  bool? product;
  int? businessId;

  LocalBussinessModel({
    this.location,
    this.featured,
    this.promotion,
    this.sponsored,
    this.id,
    this.groupId,
    this.categoryId,
    this.name,
    this.subGroupId,
    this.desc,
    this.tags,
    this.action,
    this.listener,
    this.theme,
    this.icon,
    this.template,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.parentId,
    this.product,
    this.businessId,
  });

  factory LocalBussinessModel.fromJson(Map<String, dynamic> json) =>
      LocalBussinessModel(
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        featured: json["featured"],
        promotion: json["promotion"],
        sponsored: json["sponsored"],
        id: json["_id"],
        groupId: json["groupId"],
        categoryId: json["categoryId"],
        name: json["name"],
        subGroupId: json["subGroupId"],
        desc: json["desc"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        action: json["action"],
        listener: json["listener"] == null
            ? []
            : List<int>.from(json["listener"]!.map((x) => x)),
        theme: json["theme"] == null ? null : Theme.fromJson(json["theme"]),
        icon: json["icon"],
        template: json["template"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        parentId: json["parentId"],
        product: json["product"],
        businessId: json["businessId"],
      );

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "featured": featured,
        "promotion": promotion,
        "sponsored": sponsored,
        "_id": id,
        "groupId": groupId,
        "categoryId": categoryId,
        "name": name,
        "subGroupId": subGroupId,
        "desc": desc,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "action": action,
        "listener":
            listener == null ? [] : List<dynamic>.from(listener!.map((x) => x)),
        "theme": theme?.toJson(),
        "icon": icon,
        "template": template,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "parentId": parentId,
        "product": product,
        "businessId": businessId,
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
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
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
