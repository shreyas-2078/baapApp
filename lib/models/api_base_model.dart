class ApiBaseModel {
    String? authUrl;
    String? commerceUrl;
    String? gatewayUrl;
    String? memberUrl;
    String? paymentUrl;
    String? imageUploadUrl;
    String? imageResizeUrl;
    int? groupId;
    int? experienceGroupId;
    int? roleId;
    String? version;

    ApiBaseModel({
        this.authUrl,
        this.commerceUrl,
        this.gatewayUrl,
        this.memberUrl,
        this.paymentUrl,
        this.imageUploadUrl,
        this.imageResizeUrl,
        this.groupId,
        this.experienceGroupId,
        this.roleId,
        this.version,
    });

    factory ApiBaseModel.fromJson(Map<String, dynamic> json) => ApiBaseModel(
        authUrl: json["authUrl"],
        commerceUrl: json["commerceUrl"],
        gatewayUrl: json["gatewayUrl"],
        memberUrl: json["memberUrl"],
        paymentUrl: json["paymentUrl"],
        imageUploadUrl: json["imageUploadUrl"],
        imageResizeUrl: json["imageResizeUrl"],
        groupId: json["groupId"],
        experienceGroupId: json["experienceGroupId"],
        roleId: json["roleId"],
        version: json["version"],
    );

    Map<String, dynamic> toJson() => {
        "authUrl": authUrl,
        "commerceUrl": commerceUrl,
        "gatewayUrl": gatewayUrl,
        "memberUrl": memberUrl,
        "paymentUrl": paymentUrl,
        "imageUploadUrl": imageUploadUrl,
        "imageResizeUrl": imageResizeUrl,
        "groupId": groupId,
        "experienceGroupId": experienceGroupId,
        "roleId": roleId,
        "version": version,
    };
}
