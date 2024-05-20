class CustomerResponseModel {
  String? status;
  CustomerModel? data;

  CustomerResponseModel({
    this.status,
    this.data,
  });

  factory CustomerResponseModel.fromJson(Map<String, dynamic> json) =>
      CustomerResponseModel(
        status: json["status"],
        data:
            json["data"] == null ? null : CustomerModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class CustomerModel {
  String? id;
  int? groupId;
  int? phoneNumber;
  int? custId;
  String? password;
  String? name;
  String? email;
  String? pinCode;
  String? location;
  int? roleId;
  List<AddressElement>? addresses;
  List<AccountDetail>? accountDetails;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? userId;
  int? destination;
  String? gender;
  String? imageUrl;
  String? profileCircle;
  String? profileImage;
  List<MemberShipModel>? memberMembership;

  CustomerModel({
    this.id,
    this.groupId,
    this.phoneNumber,
    this.custId,
    this.password,
    this.name,
    this.email,
    this.pinCode,
    this.location,
    this.roleId,
    this.addresses,
    this.accountDetails,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.userId,
    this.destination,
    this.gender,
    this.imageUrl,
    this.profileCircle,
    this.profileImage,
    this.memberMembership,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["_id"],
        groupId: json["groupId"],
        phoneNumber: json["phoneNumber"],
        custId: json["custId"],
        password: json["password"],
        name: json["name"],
        email: json["email"],
        pinCode: json["pinCode"],
        location: json["location"],
        roleId: json["roleId"],
        addresses: json["addresses"] == null
            ? []
            : List<AddressElement>.from(
                json["addresses"]!.map((x) => AddressElement.fromJson(x))),
        accountDetails: json["accountDetails"] == null
            ? []
            : List<AccountDetail>.from(
                json["accountDetails"]!.map((x) => AccountDetail.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        userId: json["userId"],
        destination: json["destination"],
        gender: json["gender"],
        imageUrl: json["imageUrl"],
        profileCircle: json["profileCircle"],
        profileImage: json["profileImage"],
        memberMembership: json["memberMembership"] == null
            ? []
            : List<MemberShipModel>.from(json["memberMembership"]!
                .map((x) => MemberShipModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "groupId": groupId,
        "phoneNumber": phoneNumber,
        "custId": custId,
        "password": password,
        "name": name,
        "email": email,
        "pinCode": pinCode,
        "location": location,
        "roleId": roleId,
        "addresses": addresses == null
            ? []
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
        "accountDetails": accountDetails == null
            ? []
            : List<dynamic>.from(accountDetails!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "userId": userId,
        "destination": destination,
        "gender": gender,
        "imageUrl": imageUrl,
        "profileCircle": profileCircle,
        "profileImage": profileImage,
        "memberMembership": memberMembership == null
            ? []
            : List<dynamic>.from(memberMembership!.map((x) => x.toJson())),
      };
}

class AccountDetail {
  String? id;
  int? accountId;
  AccountDetails? accountDetails;

  AccountDetail({
    this.id,
    this.accountId,
    this.accountDetails,
  });

  factory AccountDetail.fromJson(Map<String, dynamic> json) => AccountDetail(
        id: json["_id"],
        accountId: json["accountId"],
        accountDetails: json["accountDetails"] == null
            ? null
            : AccountDetails.fromJson(json["accountDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "accountId": accountId,
        "accountDetails": accountDetails?.toJson(),
      };
}

class AccountDetails {
  Upi? upi;

  AccountDetails({
    this.upi,
  });

  factory AccountDetails.fromJson(Map<String, dynamic> json) => AccountDetails(
        upi: json["upi"] == null ? null : Upi.fromJson(json["upi"]),
      );

  Map<String, dynamic> toJson() => {
        "upi": upi?.toJson(),
      };
}

class Upi {
  String? upi;

  Upi({
    this.upi,
  });

  factory Upi.fromJson(Map<String, dynamic> json) => Upi(
        upi: json["upi"],
      );

  Map<String, dynamic> toJson() => {
        "upi": upi,
      };
}

class AddressElement {
  String? id;
  int? addressId;
  AddressModel? address;

  AddressElement({
    this.id,
    this.addressId,
    this.address,
  });

  static AddressElement defaultAddress() {
    return AddressElement(
      addressId: 1234,
      address: AddressModel(
        tag: 'default',
        street: 'नवीन पत्ता',
        locality: 'जोडा',
        city: ' ',
        state: ' ',
        zip: ' ',
        addressDefault: false,
      ),
    );
  }

  factory AddressElement.fromJson(Map<String, dynamic> json) => AddressElement(
        id: json["_id"],
        addressId: json["addressId"],
        address: json["address"] == null
            ? null
            : AddressModel.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "addressId": addressId,
        "address": address?.toJson(),
      };
}

class AddressModel {
  String? tag;
  String? street;
  String? locality;
  String? city;
  String? state;
  String? zip;
  bool? addressDefault;
  bool? billingAddress;

  AddressModel({
    this.tag,
    this.street,
    this.locality,
    this.city,
    this.state,
    this.zip,
    this.addressDefault,
    this.billingAddress,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        tag: json["tag"],
        street: json["street"],
        locality: json["locality"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        addressDefault: json["default"],
        billingAddress: json["billingAddress"],
      );

  Map<String, dynamic> toJson() => {
        "tag": tag,
        "street": street,
        "locality": locality,
        "city": city,
        "state": state,
        "zip": zip,
        "default": addressDefault,
        "billingAddress": billingAddress,
      };
}

class MemberShipModel {
  String? membershipPremium;
  String? startDate;
  String? endDate;
  String? id;
  int? totalRewardsEarned;
  int? smartCardId;
  int? membershipId;
  String? barcodeImageUrl;

  MemberShipModel({
    this.membershipPremium,
    this.startDate,
    this.endDate,
    this.id,
    this.totalRewardsEarned,
    this.smartCardId,
    this.membershipId,
    this.barcodeImageUrl,
  });

  factory MemberShipModel.fromJson(Map<String, dynamic> json) =>
      MemberShipModel(
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
