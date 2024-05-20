
class AddCartResponseModel {
    String? status;
    AddCartResponseModelData? data;

    AddCartResponseModel({
        this.status,
        this.data,
    });

    factory AddCartResponseModel.fromJson(Map<String, dynamic> json) => AddCartResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : AddCartResponseModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class AddCartResponseModelData {
    String? status;
    AddCartModel? data;

    AddCartResponseModelData({
        this.status,
        this.data,
    });

    factory AddCartResponseModelData.fromJson(Map<String, dynamic> json) => AddCartResponseModelData(
        status: json["status"],
        data: json["data"] == null ? null : AddCartModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class AddCartModel {
    String? id;
    int? userId;
    int? groupId;
    List<Product>? products;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    AddCartModel({
        this.id,
        this.userId,
        this.groupId,
        this.products,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory AddCartModel.fromJson(Map<String, dynamic> json) => AddCartModel(
        id: json["_id"],
        userId: json["userId"],
        groupId: json["groupId"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "groupId": groupId,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Product {
    int? productcode;
    int? quantity;
    String? id;

    Product({
        this.productcode,
        this.quantity,
        this.id,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productcode: json["productcode"],
        quantity: json["quantity"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "productcode": productcode,
        "quantity": quantity,
        "_id": id,
    };
}
