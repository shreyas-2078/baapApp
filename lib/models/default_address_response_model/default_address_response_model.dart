class DefalutAddressResponseModel {
    AddressModel? data;

    DefalutAddressResponseModel({
        this.data,
    });

    factory DefalutAddressResponseModel.fromJson(Map<String, dynamic> json) => DefalutAddressResponseModel(
        data: json["data"] == null ? null : AddressModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class AddressModel {
    String? id;
    int? addressId;
    Address? address;

    AddressModel({
        this.id,
        this.addressId,
        this.address,
    });

    factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["_id"],
        addressId: json["addressId"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "addressId": addressId,
        "address": address?.toJson(),
    };
}

class Address {
    String? tag;
    String? street;
    String? locality;
    String? city;
    String? state;
    String? zip;
    bool? addressDefault;

    Address({
        this.tag,
        this.street,
        this.locality,
        this.city,
        this.state,
        this.zip,
        this.addressDefault,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        tag: json["tag"],
        street: json["street"],
        locality: json["locality"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        addressDefault: json["default"],
    );

    Map<String, dynamic> toJson() => {
        "tag": tag,
        "street": street,
        "locality": locality,
        "city": city,
        "state": state,
        "zip": zip,
        "default": addressDefault,
    };
}
