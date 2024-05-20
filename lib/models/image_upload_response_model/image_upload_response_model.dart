class ImageUploadResponseModel {
  String? url;
  String? fileName;

  ImageUploadResponseModel({
    this.url,
    this.fileName,
  });

  factory ImageUploadResponseModel.fromJson(Map<String, dynamic> json) =>
      ImageUploadResponseModel(
        url: json["url"],
        fileName: json["fileName"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "fileName": fileName,
      };
}
