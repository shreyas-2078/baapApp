// import 'dart:convert';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// class LocalizationChecker {
//   static changeLanguage(BuildContext context, Locale locale) {
//     EasyLocalization.of(context)!.setLocale(locale);
//   }
// }

// class CustomLocalizationDelegate extends EasyLocalizationDelegate {
//   @override
//   Future<Map<String, dynamic>> load(Locale locale) async {
//     final response = await http.get(
//       Uri.parse('https://5qkm38ij1a.execute-api.us-east-2.amazonaws.com/token/getAll?appId=GP&languageCode=${locale.languageCode}-${locale.countryCode}'),
//     );

// ignore_for_file: unnecessary_import

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load translations');
//     }
//   }
// }
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';

 class LocalizationChecker {
  static changeLanguage(BuildContext context, Locale locale) {
    EasyLocalization.of(context)!.setLocale(locale);
  }
}
class CustomLocalizationDelegate {
  Future<Map<String, dynamic>> load(Locale locale) async {
    final response = await http.get(
      Uri.parse('https://5qkm38ij1a.execute-api.us-east-2.amazonaws.com/token/getAll?appId=GP&languageCode=${locale.languageCode}-${locale.countryCode}'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load translations');
    }
  }
}

