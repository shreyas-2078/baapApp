

// ignore_for_file: prefer_collection_literals

class LanguagesModel {
  String? status;
  List<Data>? data;

  LanguagesModel({this.status, this.data});

  LanguagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? appId;
  String? languageCode;
  String? token;
  int? iV;
  String? value;

  Data(
      {this.sId,
      this.appId,
      this.languageCode,
      this.token,
      this.iV,
      this.value});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    appId = json['appId'];
    languageCode = json['languageCode'];
    token = json['token'];
    iV = json['__v'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['appId'] = appId;
    data['languageCode'] = languageCode;
    data['token'] = token;
    data['__v'] = iV;
    data['value'] = value;
    return data;
  }
}