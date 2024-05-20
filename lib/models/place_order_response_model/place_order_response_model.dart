class PlaceOrderResponseModel {
  String? status;
  PlaceOrderModel? data;

  PlaceOrderResponseModel({
    this.status,
    this.data,
  });

  factory PlaceOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      PlaceOrderResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : PlaceOrderModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class PlaceOrderModel {
  int? groupId;
  Customer? customer;
  List<Product>? products;
  bool? paid;
  int? orderId;
  String? status;
  String? id;
  int? totalAmount;
  String? currency;
  String? source;
  PaymentInfo? paymentInfo;
  DeliveryInfo? deliveryInfo;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  PlaceOrderModel({
    this.groupId,
    this.customer,
    this.products,
    this.paid,
    this.orderId,
    this.status,
    this.id,
    this.totalAmount,
    this.currency,
    this.source,
    this.paymentInfo,
    this.deliveryInfo,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      PlaceOrderModel(
        groupId: json["groupId"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        paid: json["paid"],
        orderId: json["orderId"],
        status: json["status"],
        id: json["_id"],
        totalAmount: json["total_amount"],
        currency: json["currency"],
        source: json["source"],
        paymentInfo: json["paymentInfo"] == null
            ? null
            : PaymentInfo.fromJson(json["paymentInfo"]),
        deliveryInfo: json["delivery_info"] == null
            ? null
            : DeliveryInfo.fromJson(json["delivery_info"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "customer": customer?.toJson(),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "paid": paid,
        "orderId": orderId,
        "status": status,
        "_id": id,
        "total_amount": totalAmount,
        "currency": currency,
        "source": source,
        "paymentInfo": paymentInfo?.toJson(),
        "delivery_info": deliveryInfo?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Customer {
  int? userId;
  String? name;
  int? phoneNumber;

  Customer({
    this.userId,
    this.name,
    this.phoneNumber,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        userId: json["userId"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "phoneNumber": phoneNumber,
      };
}

class DeliveryInfo {
  ShippingAddress? shippingAddress;

  DeliveryInfo({
    this.shippingAddress,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) => DeliveryInfo(
        shippingAddress: json["shipping_address"] == null
            ? null
            : ShippingAddress.fromJson(json["shipping_address"]),
      );

  Map<String, dynamic> toJson() => {
        "shipping_address": shippingAddress?.toJson(),
      };
}

class ShippingAddress {
  String? street;
  String? locality;
  String? city;
  String? state;
  String? zip;

  ShippingAddress({
    this.street,
    this.locality,
    this.city,
    this.state,
    this.zip,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        street: json["street"],
        locality: json["locality"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "locality": locality,
        "city": city,
        "state": state,
        "zip": zip,
      };
}

class PaymentInfo {
  String? mode;

  PaymentInfo({
    this.mode,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
        mode: json["mode"],
      );

  Map<String, dynamic> toJson() => {
        "mode": mode,
      };
}

class Product {
  int? productcode;
  int? quantity;

  Product({
    this.productcode,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productcode: json["productcode"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productcode": productcode,
        "quantity": quantity,
      };
}
