class OrderDetailsResponseModel {
  String? status;
  Data? data;
  int? totalItemsCount;
  int? totalPages;

  OrderDetailsResponseModel({
    this.status,
    this.data,
    this.totalItemsCount,
    this.totalPages,
  });

  factory OrderDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        totalItemsCount: json["totalItemsCount"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "totalItemsCount": totalItemsCount,
        "totalPages": totalPages,
      };
}

class Data {
  List<OrderDetailsModel>? items;

  Data({
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null
            ? []
            : List<OrderDetailsModel>.from(
                json["items"]!.map((x) => OrderDetailsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class OrderDetailsModel {
  String? id;
  int? groupId;
  List<OrderDetail>? orderDetails;
  int? orderId;
  String? status;
  String? event;
  UserId? userId;
  int? subtotal;
  int? taxes;
  int? saving;
  int? totalCartPrice;
  int? totalProductQuantity;
  String? currency;
  String? source;
  DeliveryInfo? deliveryInfo;
  PaymentInfo? paymentInfo;
  String? lat;
  String? lon;
  DateTime? orderDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? phoneNumber;
  String? name;
  Location? location;
  int? handedBy;
  String? refNo;
  ShippingDetails? shippingDetails;

  OrderDetailsModel({
    this.id,
    this.groupId,
    this.orderDetails,
    this.orderId,
    this.status,
    this.event,
    this.userId,
    this.subtotal,
    this.taxes,
    this.saving,
    this.totalProductQuantity,
    this.totalCartPrice,
    this.currency,
    this.source,
    this.deliveryInfo,
    this.paymentInfo,
    this.lat,
    this.lon,
    this.orderDate,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.name,
    this.phoneNumber,
    this.location,
    this.handedBy,
    this.refNo,
    this.shippingDetails,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        id: json["_id"],
        groupId: json["groupId"],
        orderDetails: json["orderDetails"] == null
            ? []
            : List<OrderDetail>.from(
                json["orderDetails"]!.map((x) => OrderDetail.fromJson(x))),
        orderId: json["orderId"],
        status: json["status"],
        event: json["event"],
        userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
        subtotal: json["subtotal"],
        saving: json["saving"],
        taxes: json["taxes"],
        totalProductQuantity: json["totalProductQuantity"],
        totalCartPrice: json["totalCartPrice"],
        currency: json["currency"],
        source: json["source"],
        deliveryInfo: json["delivery_info"] == null
            ? null
            : DeliveryInfo.fromJson(json["delivery_info"]),
        paymentInfo: json["paymentInfo"] == null
            ? null
            : PaymentInfo.fromJson(json["paymentInfo"]),
        lat: json["lat"],
        lon: json["lon"],
        orderDate: json["orderDate"] == null
            ? null
            : DateTime.parse(json["orderDate"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        phoneNumber: json["phoneNumber"],
        name: json["name"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        handedBy: json["handedBy"],
        refNo: json["refNo"],
        shippingDetails: json["shippingDetails"] == null
            ? null
            : ShippingDetails.fromJson(json["shippingDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "groupId": groupId,
        "orderDetails": orderDetails == null
            ? []
            : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
        "orderId": orderId,
        "status": status,
        "event": event,
        "userId": userId?.toJson(),
        "subtotal": subtotal,
        "saving": saving,
        "taxes": taxes,
        "totalProductQuantity": totalProductQuantity,
        "totalCartPrice": totalCartPrice,
        "currency": currency,
        "source": source,
        "delivery_info": deliveryInfo?.toJson(),
        "paymentInfo": paymentInfo?.toJson(),
        "lat": lat,
        "lon": lon,
        "orderDate": orderDate?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "phoneNumber": phoneNumber,
        "name": name,
        "location": location?.toJson(),
        "handedBy": handedBy,
        "refNo": refNo,
        "shippingDetails": shippingDetails?.toJson(),
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
  bool? shippingAddress;

  ShippingAddress({
    this.street,
    this.locality,
    this.city,
    this.state,
    this.zip,
    this.shippingAddress,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        street: json["street"],
        locality: json["locality"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        shippingAddress: json["shippingAddress"],
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "locality": locality,
        "city": city,
        "state": state,
        "zip": zip,
        "shippingAddress": shippingAddress,
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
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
        "type": type,
      };
}

class OrderDetail {
  Product? product;
  int? quantity;
  int? totalProductPrice;

  OrderDetail({
    this.product,
    this.quantity,
    this.totalProductPrice,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        quantity: json["quantity"],
        totalProductPrice: json["totalProductPrice"],
      );

  Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "quantity": quantity,
        "totalProductPrice": totalProductPrice,
      };
}

class Product {
  int? productcode;
  String? name;
  int? buyingPrice;
  int? memberPrice;
  int? regularPrice;
  int? marketPrice;
  double? tax;
  double? gst;
  double? igst;
  double? cgst;
  double? sgst;
  int? serialNumber;

  Product({
    this.productcode,
    this.name,
    this.buyingPrice,
    this.memberPrice,
    this.regularPrice,
    this.marketPrice,
    this.tax,
    this.gst,
    this.igst,
    this.cgst,
    this.sgst,
    this.serialNumber,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productcode: json["productcode"],
        name: json["name"],
        buyingPrice: json["buyingPrice"],
        memberPrice: json["memberPrice"],
        regularPrice: json["regularPrice"],
        marketPrice: json["marketPrice"],
        tax: json["tax"]?.toDouble(),
        gst: json["gst"]?.toDouble(),
        igst: json["igst"]?.toDouble(),
        cgst: json["cgst"]?.toDouble(),
        sgst: json["sgst"]?.toDouble(),
        serialNumber: json["serialNumber"],
      );

  Map<String, dynamic> toJson() => {
        "productcode": productcode,
        "name": name,
        "buyingPrice": buyingPrice,
        "memberPrice": memberPrice,
        "regularPrice": regularPrice,
        "marketPrice": marketPrice,
        "tax": tax,
        "gst": gst,
        "igst": igst,
        "cgst": cgst,
        "sgst": sgst,
        "serialNumber": serialNumber,
      };
}

class PaymentInfo {
  String? mode;
  String? paymentStatus;
  dynamic txnId;
  String? upi;
  String? paymentDateTime;

  PaymentInfo({
    this.mode,
    this.paymentStatus,
    this.txnId,
    this.upi,
    this.paymentDateTime,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
        mode: json["mode"],
        paymentStatus: json["paymentStatus"],
        txnId: json["txnId"],
        upi: json["upi"],
        paymentDateTime: json["paymentDateTime"],
      );

  Map<String, dynamic> toJson() => {
        "mode": mode,
        "paymentStatus": paymentStatus,
        "txnId": txnId,
        "upi": upi,
        "paymentDateTime": paymentDateTime,
      };
}

class ShippingDetails {
  String? vehicleNo;
  String? driverName;
  String? driverNo;
  String? location;
  String? name;
  String? contactPerson;
  String? trackingNo;
  String? trackingUrl;
  String? dispatchNo;
  String? selectedDepartment;
  String? invoiceNumber;
  String? transporter;

  ShippingDetails({
    this.vehicleNo,
    this.driverName,
    this.driverNo,
    this.location,
    this.name,
    this.contactPerson,
    this.trackingNo,
    this.trackingUrl,
    this.dispatchNo,
    this.selectedDepartment,
    this.invoiceNumber,
    this.transporter,
  });

  factory ShippingDetails.fromJson(Map<String, dynamic> json) =>
      ShippingDetails(
        vehicleNo: json["vehicleNo"],
        driverName: json["driverName"],
        driverNo: json["driverNo"],
        location: json["location"],
        name: json["name"],
        contactPerson: json["contactPerson"],
        trackingNo: json["trackingNo"],
        trackingUrl: json["trackingURL"],
        dispatchNo: json["dispatchNo"],
        selectedDepartment: json["selectedDepartment"],
        invoiceNumber: json["invoiceNumber"],
        transporter: json["transporter"],
      );

  Map<String, dynamic> toJson() => {
        "vehicleNo": vehicleNo,
        "driverName": driverName,
        "driverNo": driverNo,
        "location": location,
        "name": name,
        "contactPerson": contactPerson,
        "trackingNo": trackingNo,
        "trackingURL": trackingUrl,
        "dispatchNo": dispatchNo,
        "selectedDepartment": selectedDepartment,
        "invoiceNumber": invoiceNumber,
        "transporter": transporter,
      };
}

class UserId {
  int? userId;
  int? phoneNumber;
  String? name;
  List<Membership>? membership;
  String? location;
  String? pinCode;

  UserId({
    this.userId,
    this.phoneNumber,
    this.name,
    this.membership,
    this.location,
    this.pinCode,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        userId: json["userId"],
        phoneNumber: json["phoneNumber"],
        name: json["name"],
        membership: json["membership"] == null
            ? []
            : List<Membership>.from(
                json["membership"]!.map((x) => Membership.fromJson(x))),
        location: json["location"],
        pinCode: json["pinCode"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "phoneNumber": phoneNumber,
        "name": name,
        "membership": membership == null
            ? []
            : List<dynamic>.from(membership!.map((x) => x.toJson())),
        "location": location,
        "pinCode": pinCode,
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
