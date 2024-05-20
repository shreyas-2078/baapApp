
class OrderListResponseModel {
    String? message;
    Data? data;
    int? totalItemsCount;
    int? totalPages;

    OrderListResponseModel({
        this.message,
        this.data,
        this.totalItemsCount,
        this.totalPages,
    });

    factory OrderListResponseModel.fromJson(Map<String, dynamic> json) => OrderListResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        totalItemsCount: json["totalItemsCount"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "totalItemsCount": totalItemsCount,
        "totalPages": totalPages,
    };
}

class Data {
    List<OrderData>? items;

    Data({
        this.items,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null ? [] : List<OrderData>.from(json["items"]!.map((x) => OrderData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class OrderData {
    String? id;
    int? groupId;
    List<OrderDetail>? orderDetails;
    int? orderId;
    String? status;
    String? event;
    UserId? userId;
    int? subtotal;
    int? saving;
    int? taxes;
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
    SubcategoryId? subcategoryId;
    BusinessId? businessId;
    int? totalCardPrice;
    int? paidAmount;
    int? remainingAmount;
    String? driverName;
    String? vehicleNo;
    String? driverNo;
    dynamic location;
    String? name;
    String? contactPerson;
    String? trackingNo;
    String? trackingUrl;
    String? selectedDepartment;
    DateTime? orderData;

    OrderData({
        this.id,
        this.groupId,
        this.orderDetails,
        this.orderId,
        this.status,
        this.event,
        this.userId,
        this.subtotal,
        this.saving,
        this.taxes,
        this.totalCartPrice,
        this.totalProductQuantity,
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
        this.subcategoryId,
        this.businessId,
        this.totalCardPrice,
        this.paidAmount,
        this.remainingAmount,
        this.driverName,
        this.vehicleNo,
        this.driverNo,
        this.location,
        this.name,
        this.contactPerson,
        this.trackingNo,
        this.trackingUrl,
        this.selectedDepartment,
        this.orderData,
    });

    factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["_id"],
        groupId: json["groupId"],
        orderDetails: json["orderDetails"] == null ? [] : List<OrderDetail>.from(json["orderDetails"]!.map((x) => OrderDetail.fromJson(x))),
        orderId: json["orderId"],
        status: json["status"],
        event: json["event"],
        userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
        subtotal: json["subtotal"],
        saving: json["saving"],
        taxes: json["taxes"],
        totalCartPrice: json["totalCartPrice"],
        totalProductQuantity: json["totalProductQuantity"],
        currency: json["currency"],
        source: json["source"],
        deliveryInfo: json["delivery_info"] == null ? null : DeliveryInfo.fromJson(json["delivery_info"]),
        paymentInfo: json["paymentInfo"] == null ? null : PaymentInfo.fromJson(json["paymentInfo"]),
        lat: json["lat"],
        lon: json["lon"],
        orderDate: json["orderDate"] == null ? null : DateTime.parse(json["orderDate"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        subcategoryId: json["subcategoryId"] == null ? null : SubcategoryId.fromJson(json["subcategoryId"]),
        businessId: json["businessId"] == null ? null : BusinessId.fromJson(json["businessId"]),
        totalCardPrice: json["TotalCardPrice"],
        paidAmount: json["PaidAmount"],
        remainingAmount: json["RemainingAmount"],
        driverName: json["driverName"],
        vehicleNo: json["vehicleNo"],
        driverNo: json["driverNo"],
        location: json["location"],
        name: json["name"],
        contactPerson: json["contactPerson"],
        trackingNo: json["trackingNo"],
        trackingUrl: json["trackingURL"],
        selectedDepartment: json["selectedDepartment"],
        orderData: json["orderData"] == null ? null : DateTime.parse(json["orderData"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "groupId": groupId,
        "orderDetails": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
        "orderId": orderId,
        "status": status,
        "event": event,
        "userId": userId?.toJson(),
        "subtotal": subtotal,
        "saving": saving,
        "taxes": taxes,
        "totalCartPrice": totalCartPrice,
        "totalProductQuantity": totalProductQuantity,
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
        "subcategoryId": subcategoryId?.toJson(),
        "businessId": businessId?.toJson(),
        "TotalCardPrice": totalCardPrice,
        "PaidAmount": paidAmount,
        "RemainingAmount": remainingAmount,
        "driverName": driverName,
        "vehicleNo": vehicleNo,
        "driverNo": driverNo,
        "location": location,
        "name": name,
        "contactPerson": contactPerson,
        "trackingNo": trackingNo,
        "trackingURL": trackingUrl,
        "selectedDepartment": selectedDepartment,
        "orderData": orderData?.toIso8601String(),
    };
}

class BusinessId {
    String? name;
    String? categoryId;
    List<dynamic>? listener;
    String? location;
    String? subGroupId;

    BusinessId({
        this.name,
        this.categoryId,
        this.listener,
        this.location,
        this.subGroupId,
    });

    factory BusinessId.fromJson(Map<String, dynamic> json) => BusinessId(
        name: json["name"],
        categoryId: json["categoryId"],
        listener: json["listener"] == null ? [] : List<dynamic>.from(json["listener"]!.map((x) => x)),
        location: json["location"],
        subGroupId: json["subGroupId"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "categoryId": categoryId,
        "listener": listener == null ? [] : List<dynamic>.from(listener!.map((x) => x)),
        "location": location,
        "subGroupId": subGroupId,
    };
}

class DeliveryInfo {
    ShippingAddress? shippingAddress;
    BillingAddress? billingAddress;
    String? id;

    DeliveryInfo({
        this.shippingAddress,
        this.billingAddress,
        this.id,
    });

    factory DeliveryInfo.fromJson(Map<String, dynamic> json) => DeliveryInfo(
        shippingAddress: json["shipping_address"] == null ? null : ShippingAddress.fromJson(json["shipping_address"]),
        billingAddress: json["billing_address"] == null ? null : BillingAddress.fromJson(json["billing_address"]),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "shipping_address": shippingAddress?.toJson(),
        "billing_address": billingAddress?.toJson(),
        "_id": id,
    };
}

class BillingAddress {
    bool? billingAddress;

    BillingAddress({
        this.billingAddress,
    });

    factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
        billingAddress: json["billingAddress"],
    );

    Map<String, dynamic> toJson() => {
        "billingAddress": billingAddress,
    };
}

class ShippingAddress {
    String? street;
    String? locality;
    String? city;
    String? state;
    String? zip;
    bool? shippingAddress;
    String? id;

    ShippingAddress({
        this.street,
        this.locality,
        this.city,
        this.state,
        this.zip,
        this.shippingAddress,
        this.id,
    });

    factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
        street: json["street"],
        locality: json["locality"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        shippingAddress: json["shippingAddress"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "street": street,
        "locality": locality,
        "city": city,
        "state": state,
        "zip": zip,
        "shippingAddress": shippingAddress,
        "_id": id,
    };
}

class OrderDetail {
    int? quantity;
    int? totalProductPrice;
    Product? product;
    String? id;

    OrderDetail({
        this.quantity,
        this.totalProductPrice,
        this.product,
        this.id,
    });

    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        quantity: json["quantity"],
        totalProductPrice: json["totalProductPrice"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "totalProductPrice": totalProductPrice,
        "product": product?.toJson(),
        "_id": id,
    };
}

class Product {
    int? productcode;
    String? name;
    int? buyingPrice;
    int? memberPrice;
    int? regularPrice;
    int? marketPrice;
    int? gst;
    int? igst;
    int? cgst;
    int? sgst;
    int? tax;
    int? serialNumber;
    String? id;

    Product({
        this.productcode,
        this.name,
        this.buyingPrice,
        this.memberPrice,
        this.regularPrice,
        this.marketPrice,
        this.gst,
        this.igst,
        this.cgst,
        this.sgst,
        this.tax,
        this.serialNumber,
        this.id,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productcode: json["productcode"],
        name: json["name"],
        buyingPrice: json["buyingPrice"],
        memberPrice: json["memberPrice"],
        regularPrice: json["regularPrice"],
        marketPrice: json["marketPrice"],
        gst: json["gst"],
        igst: json["igst"],
        cgst: json["cgst"],
        sgst: json["sgst"],
        tax: json["tax"],
        serialNumber: json["serialNumber"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "productcode": productcode,
        "name": name,
        "buyingPrice": buyingPrice,
        "memberPrice": memberPrice,
        "regularPrice": regularPrice,
        "marketPrice": marketPrice,
        "gst": gst,
        "igst": igst,
        "cgst": cgst,
        "sgst": sgst,
        "tax": tax,
        "serialNumber": serialNumber,
        "_id": id,
    };
}

class PaymentInfo {
    String? mode;
    String? paymentStatus;
    String? upi;
    String? txnId;
    int? loggedInUser;
    String? paymentDateTime;
    String? id;

    PaymentInfo({
        this.mode,
        this.paymentStatus,
        this.upi,
        this.txnId,
        this.loggedInUser,
        this.paymentDateTime,
        this.id,
    });

    factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
        mode: json["mode"],
        paymentStatus: json["paymentStatus"],
        upi: json["upi"],
        txnId: json["txnId"],
        loggedInUser: json["loggedInUser"],
        paymentDateTime: json["paymentDateTime"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "mode": mode,
        "paymentStatus": paymentStatus,
        "upi": upi,
        "txnId": txnId,
        "loggedInUser": loggedInUser,
        "paymentDateTime": paymentDateTime,
        "_id": id,
    };
}

class SubcategoryId {
    String? name;
    String? subcategoryId;
    String? categoryId;
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
    String? location;
    String? pinCode;

    UserId({
        this.phoneNumber,
        this.name,
        this.userId,
        this.location,
        this.pinCode,
    });

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        phoneNumber: json["phoneNumber"],
        name: json["name"],
        userId: json["userId"],
        location: json["location"],
        pinCode: json["pinCode"],
    );

    Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "name": name,
        "userId": userId,
        "location": location,
        "pinCode": pinCode,
    };
}
