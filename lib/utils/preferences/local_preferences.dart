import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/jwt_token_response_model/jwt_token_response_model.dart';

class LocalStorageUtils {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  static JwtTokeResponseModel get tokenResponseModel => userData();

  static Future<void> saveUserDetails(String token) async {
    await instance.setString("token", token);
  }

  static Future<void> saveGeoLocation(double lat, double lon) async {
    await instance.setDouble("latitude", lat);
    await instance.setDouble("longitude", lon);
  }

  static Future<void> saveLocationAndPin(String name, String pinCode) async {
    await instance.setString("locationName", name);
    await instance.setString("locationPin", pinCode);
  }

  static String? getLocationName() {
    final locationName = instance.getString('locationName');
    return locationName;
  }

  static String? getlocationPin() {
    final locationPin = instance.getString('locationPin');
    return locationPin;
  }

  static double? getLatitude() {
    final latitude = instance.getDouble('latitude');
    return latitude;
  }

  static Future<void> setDistance(double distance) async {
    await instance.setDouble("distance", distance);
  }

  static double? getDistance() {
    final distance = instance.getDouble('distance');
    final meter = (distance ?? 40) * 1000;
    return meter;
  }

  static double? getLongitude() {
    final latitude = instance.getDouble('longitude');
    return latitude;
  }

  static Future<String?> fetchToken() async {
    final token = instance.getString('token') ?? '';

    if (token.isEmpty) {
      return "";
    }

    return token;
  }

  static Future<void> clear() async {
    await instance.clear();
  }

  static JwtTokeResponseModel userData() {
    final token = instance.getString('token') ?? '';
    var userData = JwtDecoder.decode(token);
    var userDecoded = JwtTokeResponseModel.fromJson(userData);
    return userDecoded;
  }
}
