// To parse this JSON data, do
class CartResponseModel {
  String? status;
  CartModel? data;

  CartResponseModel({
    this.status,
    this.data,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) =>
      CartResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : CartModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class CartModel {
  String? id;
  int? userId;
  int? groupId;
  List<Product>? products;
  int? cartId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? subtotal;
  double? taxes;
  int? saving;
  int? totalProductQuantity;
  double? totalCartPrice;

  CartModel({
    this.id,
    this.userId,
    this.groupId,
    this.products,
    this.cartId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.subtotal,
    this.taxes,
    this.saving,
    this.totalProductQuantity,
    this.totalCartPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["_id"],
        userId: json["userId"],
        groupId: json["groupId"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        cartId: json["cartId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        subtotal: json["subtotal"],
        taxes: json["taxes"]?.toDouble(),
        saving: json["saving"],
        totalProductQuantity: json["totalProductQuantity"],
        totalCartPrice: json["totalCartPrice"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "groupId": groupId,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "cartId": cartId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "subtotal": subtotal,
        "taxes": taxes,
        "saving": saving,
        "totalProductQuantity": totalProductQuantity,
        "totalCartPrice": totalCartPrice,
      };
}

class Product {
  Productcode? productcode;
  int? quantity;
  int? totalProductPrice;

  Product({
    this.productcode,
    this.quantity,
    this.totalProductPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productcode: json["productcode"] == null
            ? null
            : Productcode.fromJson(json["productcode"]),
        quantity: json["quantity"],
        totalProductPrice: json["totalProductPrice"],
      );

  Map<String, dynamic> toJson() => {
        "productcode": productcode?.toJson(),
        "quantity": quantity,
        "totalProductPrice": totalProductPrice,
      };
}

class Productcode {
  int? productcode;
  String? name;
  int? categoryId;
  int? subcategoryId;
  List<String>? pictures;
  int? buyingPrice;
  int? memberPrice;
  int? regularPrice;
  int? marketPrice;
  int? serialNumber;
  double? gst;
  double? igst;
  double? sgst;
  double? cgst;
  double? tax;

  Productcode({
    this.productcode,
    this.name,
    this.categoryId,
    this.subcategoryId,
    this.pictures,
    this.buyingPrice,
    this.memberPrice,
    this.regularPrice,
    this.marketPrice,
    this.serialNumber,
    this.gst,
    this.igst,
    this.sgst,
    this.cgst,
    this.tax,
  });

  factory Productcode.fromJson(Map<String, dynamic> json) => Productcode(
        productcode: json["productcode"],
        name: json["name"],
        categoryId: json["categoryId"],
        subcategoryId: json["subcategoryId"],
        pictures: json["pictures"] == null
            ? []
            : List<String>.from(json["pictures"]!.map((x) => x)),
        buyingPrice: json["buyingPrice"],
        memberPrice: json["memberPrice"],
        regularPrice: json["regularPrice"],
        marketPrice: json["marketPrice"],
        serialNumber: json["serialNumber"],
        gst: json["gst"]?.toDouble(),
        igst: json["igst"]?.toDouble(),
        sgst: json["sgst"]?.toDouble(),
        cgst: json["cgst"]?.toDouble(),
        tax: json["tax"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "productcode": productcode,
        "name": name,
        "categoryId": categoryId,
        "subcategoryId": subcategoryId,
        "pictures":
            pictures == null ? [] : List<dynamic>.from(pictures!.map((x) => x)),
        "buyingPrice": buyingPrice,
        "memberPrice": memberPrice,
        "regularPrice": regularPrice,
        "marketPrice": marketPrice,
        "serialNumber": serialNumber,
        "gst": gst,
        "igst": igst,
        "sgst": sgst,
        "cgst": cgst,
        "tax": tax,
      };
}
