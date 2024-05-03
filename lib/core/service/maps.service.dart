import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart' as geo_co;
import 'package:geolocator/geolocator.dart';

class MapsService with ChangeNotifier {
  String finalAddress = 'Searching...';
  String? countryName;
  String mainAddress = 'Please Select Any Place In Order To Get Address';

  double? initialLat;
  double? initialLong;

  Future<void> getCurrentLocation() async {
    try {
      var positionData = await Geolocator.getCurrentPosition();
      // final coords = geo_co.Coordinates(
      //   latitude: positionData.latitude,
      //   longitude: positionData.longitude,
      // );
      initialLat = positionData.latitude;
      initialLong = positionData.longitude;
      var addresses = await geo_co.Address();
      String? mainAddress = addresses.streetAddress;
      finalAddress = mainAddress!;
      notifyListeners();
    } catch (e) {
      // Handle any errors that might occur during location retrieval or geocoding
      print('Error getting current location: $e');
    }
  }
}
