
class CategoryResponseModel {
    String? status;
    Data? data;

    CategoryResponseModel({
        this.status,
        this.data,
    });

    factory CategoryResponseModel.fromJson(Map<String, dynamic> json) => CategoryResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    List<CategoryModel>? items;
    int? totalItemsCount;

    Data({
        this.items,
        this.totalItemsCount,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null ? [] : List<CategoryModel>.from(json["items"]!.map((x) => CategoryModel.fromJson(x))),
        totalItemsCount: json["totalItemsCount"],
    );

    Map<String, dynamic> toJson() => {
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalItemsCount": totalItemsCount,
    };
}

class CategoryModel {
    List<String>? tags;
    String? id;
    String? name;
    int? groupId;
    int? categoryId;
    String? userId;
    bool? subcategory;
    String? imageUrl;
    String? description;
    String? pictures;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    bool? product;
    bool? empty;
    String? slug;
    String? parentCategory;

    CategoryModel({
        this.tags,
        this.id,
        this.name,
        this.groupId,
        this.categoryId,
        this.userId,
        this.subcategory,
        this.imageUrl,
        this.description,
        this.pictures,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.product,
        this.empty,
        this.slug,
        this.parentCategory,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
        id: json["_id"],
        name: json["name"],
        groupId: json["groupId"],
        categoryId: json["categoryId"],
        userId: json["userId"],
        subcategory: json["subcategory"],
        imageUrl: json["imageUrl"],
        description: json["description"],
        pictures: json["pictures"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        product: json["product"],
        empty: json["प्रॉडक्ट "],
        slug: json["slug"],
        parentCategory: json["parentCategory"],
    );

    Map<String, dynamic> toJson() => {
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "_id": id,
        "name": name,
        "groupId": groupId,
        "categoryId": categoryId,
        "userId": userId,
        "subcategory": subcategory,
        "imageUrl": imageUrl,
        "description": description,
        "pictures": pictures,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "product": product,
        "प्रॉडक्ट ": empty,
        "slug": slug,
        "parentCategory": parentCategory,
    };
}
