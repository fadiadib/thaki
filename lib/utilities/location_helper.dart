import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:geolocation/geolocation.dart' as geo;

class TkPosition {
  TkPosition({this.latitude, this.longitude});

  double longitude;
  double latitude;
}

/// Wrapper for the geolocation features
class TkLocationNotifier extends ChangeNotifier {
  // Create singleton
  static final TkLocationNotifier _singleton = TkLocationNotifier._internal();
  factory TkLocationNotifier() => _singleton;
  TkLocationNotifier._internal();

  /// Converts from degrees to radian
  double deg2rad(deg) => deg * (22 / 7 / 180);

  /// Holds the location access
  static geo.GeolocationResult _geoPermission;

  /// Holds current device position
  TkPosition _currentPosition;

  /// Getter - returns the current device position
  TkPosition get currentPosition => _currentPosition;

  /// Returns true if the devise location is valid
  bool isValidLocation() {
    return _currentPosition != null &&
        _currentPosition.latitude != 0 &&
        _currentPosition.longitude != 0;
  }

  /// Normalizes the distance to a specific location
  String normalizeDistanceToLocation(int distance) {
    if (distance == -1) return '-';

    return distance > 1000
        ? (distance ~/ 1000).toInt().toString()
        : distance.toInt().toString();
  }

  /// Calculates the distance between the device and another
  /// location using its latitude and longitude
  int getDistanceFromLatLong(String lat, String long) {
    if (!isValidLocation()) return 0;

    var earthRadius = 6371; // Radius of the earth in km

    var dLat = deg2rad((double.tryParse(lat ?? "0") ?? 0) -
        (_currentPosition.latitude ?? 0)); // deg2rad below

    var dLon = deg2rad((double.tryParse(long ?? "0") ?? 0) -
        (_currentPosition.longitude ?? 0));

    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(deg2rad((double.tryParse(lat ?? "0") ?? 0))) *
            cos(deg2rad(_currentPosition.latitude ?? 0)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    var c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return (earthRadius * c * 1000).toInt(); // Distance in meters
  }

  /// Requests location access from the user
  Future<void> requestLocationAccess({bool listen = true}) async {
    _geoPermission = await geo.Geolocation.requestLocationPermission(
      permission: const geo.LocationPermission(
        android: geo.LocationPermissionAndroid.fine,
        ios: geo.LocationPermissionIOS.whenInUse,
      ),
      openSettingsIfDenied: false,
    );

    if (_geoPermission.isSuccessful) {
      _currentPosition = await getCurrentPosition();
      notifyListeners();
    } else {
      _currentPosition = null;
      notifyListeners();
    }

    // Start listening to location updates
    if (listen) listenToLocationUpdates();
  }

  /// Returns the current Position of the device
  Future<TkPosition> getCurrentPosition() async {
    geo.LocationResult result = await geo.Geolocation.lastKnownLocation();
    return new TkPosition(
      longitude: result.isSuccessful && result.location != null
          ? result.location.longitude
          : 0.0,
      latitude: result.isSuccessful && result.location != null
          ? result.location.latitude
          : 0.0,
    );
  }

  /// Adds a listener callback to any updates in the geo location
  void listenToLocationUpdates() {
    geo.Geolocation.locationUpdates(
      accuracy: geo.LocationAccuracy.best,
      displacementFilter: 10.0, // in meters
      inBackground: false,
    ).listen((result) {
      if (result.isSuccessful) {
        _currentPosition = TkPosition(
          latitude: result.location.latitude,
          longitude: result.location.longitude,
        );
        notifyListeners();
      } else {
        _currentPosition = null;
      }
    });
  }
}
