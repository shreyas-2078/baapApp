part of 'location_cubit.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationStateGranted extends LocationState {}

class LocationStateDenied extends LocationState {
  String? message;
  LocationStateDenied({this.message});
}

class LocationStateSkiped extends LocationState {}

class LocationPremited extends LocationState {
  String? latitude;
  String? longnitude;
  LocationPremited({this.latitude, this.longnitude});
}
