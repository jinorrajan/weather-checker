import 'package:flutter/material.dart';

class LocationModel extends ChangeNotifier {
  String? latitude;
  String? longitude;

  LocationModel({
     this.latitude,
     this.longitude,
  });

  void setLocation(String lat, String lon) {
    latitude = lat;
    longitude = lon;
    notifyListeners();
  }
}

class Address {
  final String place;

  Address(this.place);
}
