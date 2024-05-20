
class GroupResponseModel {
    String? status;
    GroupModel? data;

    GroupResponseModel({
        this.status,
        this.data,
    });

    factory GroupResponseModel.fromJson(Map<String, dynamic> json) => GroupResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : GroupModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class GroupModel {
    List<dynamic>? accountDetails;
    String? id;
    int? parentId;
    String? name;
    String? shortName;
    int? groupId;
    String? type;
    ContactInfo? contactInfo;
    List<dynamic>? administrators;
    CommonSettings? commonSettings;
    ThemingOptions? themingOptions;
    Location? location;
    Addresses? addresses;
    Legal? legal;
    List<Account>? accounts;
    String? logoUrl;
    String? mobileLogoUrl;
    String? mobileCoverImage;
    String? coverUrl;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? email;
    String? phone;
    String? profilePic;
    String? whatsapp;

    GroupModel({
        this.accountDetails,
        this.id,
        this.parentId,
        this.name,
        this.shortName,
        this.groupId,
        this.type,
        this.contactInfo,
        this.administrators,
        this.commonSettings,
        this.themingOptions,
        this.location,
        this.addresses,
        this.legal,
        this.accounts,
        this.logoUrl,
        this.mobileLogoUrl,
        this.mobileCoverImage,
        this.coverUrl,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.email,
        this.phone,
        this.profilePic,
        this.whatsapp,
    });

    factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        accountDetails: json["accountDetails"] == null ? [] : List<dynamic>.from(json["accountDetails"]!.map((x) => x)),
        id: json["_id"],
        parentId: json["parentId"],
        name: json["name"],
        shortName: json["shortName"],
        groupId: json["groupId"],
        type: json["type"],
        contactInfo: json["contactInfo"] == null ? null : ContactInfo.fromJson(json["contactInfo"]),
        administrators: json["administrators"] == null ? [] : List<dynamic>.from(json["administrators"]!.map((x) => x)),
        commonSettings: json["commonSettings"] == null ? null : CommonSettings.fromJson(json["commonSettings"]),
        themingOptions: json["themingOptions"] == null ? null : ThemingOptions.fromJson(json["themingOptions"]),
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        addresses: json["addresses"] == null ? null : Addresses.fromJson(json["addresses"]),
        legal: json["legal"] == null ? null : Legal.fromJson(json["legal"]),
        accounts: json["accounts"] == null ? [] : List<Account>.from(json["accounts"]!.map((x) => Account.fromJson(x))),
        logoUrl: json["logo_url"],
        mobileLogoUrl: json["mobile_logo_url"],
        mobileCoverImage: json["mobile_cover_image"],
        coverUrl: json["cover_url"],
        description: json["description"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        email: json["email"],
        phone: json["phone"],
        profilePic: json["profile_pic"],
        whatsapp: json["whatsapp"],
    );

    Map<String, dynamic> toJson() => {
        "accountDetails": accountDetails == null ? [] : List<dynamic>.from(accountDetails!.map((x) => x)),
        "_id": id,
        "parentId": parentId,
        "name": name,
        "shortName": shortName,
        "groupId": groupId,
        "type": type,
        "contactInfo": contactInfo?.toJson(),
        "administrators": administrators == null ? [] : List<dynamic>.from(administrators!.map((x) => x)),
        "commonSettings": commonSettings?.toJson(),
        "themingOptions": themingOptions?.toJson(),
        "location": location?.toJson(),
        "addresses": addresses?.toJson(),
        "legal": legal?.toJson(),
        "accounts": accounts == null ? [] : List<dynamic>.from(accounts!.map((x) => x.toJson())),
        "logo_url": logoUrl,
        "mobile_logo_url": mobileLogoUrl,
        "mobile_cover_image": mobileCoverImage,
        "cover_url": coverUrl,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "email": email,
        "phone": phone,
        "profile_pic": profilePic,
        "whatsapp": whatsapp,
    };
}

class Account {
    Upi? upi;
    String? id;
    BankDetiles? bankDetiles;

    Account({
        this.upi,
        this.id,
        this.bankDetiles,
    });

    factory Account.fromJson(Map<String, dynamic> json) => Account(
        upi: json["upi"] == null ? null : Upi.fromJson(json["upi"]),
        id: json["_id"],
        bankDetiles: json["bankDetiles"] == null ? null : BankDetiles.fromJson(json["bankDetiles"]),
    );

    Map<String, dynamic> toJson() => {
        "upi": upi?.toJson(),
        "_id": id,
        "bankDetiles": bankDetiles?.toJson(),
    };
}

class BankDetiles {
    String? bankName;
    int? accountNumber;
    String? bankAddress;

    BankDetiles({
        this.bankName,
        this.accountNumber,
        this.bankAddress,
    });

    factory BankDetiles.fromJson(Map<String, dynamic> json) => BankDetiles(
        bankName: json["bankName"],
        accountNumber: json["accountNumber"],
        bankAddress: json["bankAddress"],
    );

    Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "accountNumber": accountNumber,
        "bankAddress": bankAddress,
    };
}

class Upi {
    String? upiId;

    Upi({
        this.upiId,
    });

    factory Upi.fromJson(Map<String, dynamic> json) => Upi(
        upiId: json["upiId"],
    );

    Map<String, dynamic> toJson() => {
        "upiId": upiId,
    };
}

class Addresses {
    String? type;
    String? house;
    String? street;
    String? city;
    String? state;
    String? country;
    int? piNcode;

    Addresses({
        this.type,
        this.house,
        this.street,
        this.city,
        this.state,
        this.country,
        this.piNcode,
    });

    factory Addresses.fromJson(Map<String, dynamic> json) => Addresses(
        type: json["type"],
        house: json["house"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        piNcode: json["PINcode"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "house": house,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "PINcode": piNcode,
    };
}

class CommonSettings {
    String? currency;
    String? dateTime;
    String? defaultLanguage;
    bool? showPhoneNumbers;
    bool? enableChat;
    bool? enableCamera;
    bool? isPaymentOffline;
    bool? isPaymentOnine;
    bool? isPaymentSetting;
    String? timeZone;

    CommonSettings({
        this.currency,
        this.dateTime,
        this.defaultLanguage,
        this.showPhoneNumbers,
        this.enableChat,
        this.enableCamera,
        this.isPaymentOffline,
        this.isPaymentOnine,
        this.isPaymentSetting,
        this.timeZone,
    });

    factory CommonSettings.fromJson(Map<String, dynamic> json) => CommonSettings(
        currency: json["currency"],
        dateTime: json["dateTime"],
        defaultLanguage: json["defaultLanguage"],
        showPhoneNumbers: json["showPhoneNumbers"],
        enableChat: json["enableChat"],
        enableCamera: json["enableCamera"],
        isPaymentOffline: json["isPaymentOffline"],
        isPaymentOnine: json["isPaymentOnine"],
        isPaymentSetting: json["isPaymentSetting"],
        timeZone: json["timeZone"],
    );

    Map<String, dynamic> toJson() => {
        "currency": currency,
        "dateTime": dateTime,
        "defaultLanguage": defaultLanguage,
        "showPhoneNumbers": showPhoneNumbers,
        "enableChat": enableChat,
        "enableCamera": enableCamera,
        "isPaymentOffline": isPaymentOffline,
        "isPaymentOnine": isPaymentOnine,
        "isPaymentSetting": isPaymentSetting,
        "timeZone": timeZone,
    };
}

class ContactInfo {
    int? phoneNumber;
    String? emailId;
    int? whatsAppNumber;
    String? website;
    int? landline;

    ContactInfo({
        this.phoneNumber,
        this.emailId,
        this.whatsAppNumber,
        this.website,
        this.landline,
    });

    factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        phoneNumber: json["phoneNumber"],
        emailId: json["emailId"],
        whatsAppNumber: json["whatsAppNumber"],
        website: json["website"],
        landline: json["landline"],
    );

    Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "emailId": emailId,
        "whatsAppNumber": whatsAppNumber,
        "website": website,
        "landline": landline,
    };
}

class Legal {
    GstNo? gstNo;
    String? panCard;

    Legal({
        this.gstNo,
        this.panCard,
    });

    factory Legal.fromJson(Map<String, dynamic> json) => Legal(
        gstNo: json["GSTNo"] == null ? null : GstNo.fromJson(json["GSTNo"]),
        panCard: json["PANCard"],
    );

    Map<String, dynamic> toJson() => {
        "GSTNo": gstNo?.toJson(),
        "PANCard": panCard,
    };
}

class GstNo {
    String? gstin;

    GstNo({
        this.gstin,
    });

    factory GstNo.fromJson(Map<String, dynamic> json) => GstNo(
        gstin: json["GSTIN"],
    );

    Map<String, dynamic> toJson() => {
        "GSTIN": gstin,
    };
}

class Location {
    double? lattitude;
    double? longitude;

    Location({
        this.lattitude,
        this.longitude,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lattitude: json["lattitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lattitude": lattitude,
        "longitude": longitude,
    };
}

class ThemingOptions {
    String? backgroundColor;
    String? textColor;

    ThemingOptions({
        this.backgroundColor,
        this.textColor,
    });

    factory ThemingOptions.fromJson(Map<String, dynamic> json) => ThemingOptions(
        backgroundColor: json["backgroundColor"],
        textColor: json["textColor"],
    );

    Map<String, dynamic> toJson() => {
        "backgroundColor": backgroundColor,
        "textColor": textColor,
    };
}
