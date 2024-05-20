import 'package:baapapp/utils/preferences/local_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:string_extensions/string_extensions.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());
  String long = "", lat = "";

  checkGps(BuildContext context) async {
    bool servicestatus = false;
    late LocationPermission permission;

    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationStateDenied(message: 'Location परवानगी नाकारली आहे'));
        } else if (permission == LocationPermission.deniedForever) {
          emit(LocationStateDenied(message: 'Location परवानगी नाकारली आहे'));
        } else {
          getLocation();
        }
      } else if (permission == LocationPermission.whileInUse) {
        getLocation();
      } else {
        getLocation();
      }
    } else {
    }
  }

  getLocation() async {
    late Position position;
    emit(LocationStateGranted());
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    long = position.longitude.toString();
    lat = position.latitude.toString();
    emit(LocationPremited(latitude: lat, longnitude: long));
  }

  saveLocation() {
    GetStorage().write('latitude', lat);
    GetStorage().write('longitude', long);
    LocalStorageUtils.saveGeoLocation(
      lat.toDouble() ?? 0,
      long.toDouble() ?? 0,
    );
  }

  skipButtonPressed() {
    emit(LocationStateSkiped());
  }
}
