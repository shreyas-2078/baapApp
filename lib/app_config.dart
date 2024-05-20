import 'dart:convert';
import 'package:flutter/services.dart';

import 'models/api_base_model.dart';

class AppConfig {
  final ApiBaseModel? apiBaseUrlModel;

  AppConfig({this.apiBaseUrlModel});

  Future<ApiBaseModel> forEnvironment(String? env) async {
    env = env ?? 'dev';

    final contents = await rootBundle.loadString(
      'assets/env/$env.json',
    );

    final decodeJson = json.decode(contents);

    return ApiBaseModel.fromJson(decodeJson);
  }
}
