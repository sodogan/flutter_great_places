import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceLocation {
  final double _latitude;
  final double _longitude;
  final String _address;

  const PlaceLocation({
    required double latitude,
    required double longtitude,
    required String address,
  })  : _latitude = latitude,
        _longitude = longtitude,
        _address = address;

  const PlaceLocation.none()
      : _latitude = 37.4228325022329,
        _longitude = -122.08398242810942,
        _address = 'GooglePlex Center';

  double get latitude => _latitude;
  double get longitude => _longitude;
  String get address => _address;

  LatLng get toLatLng => LatLng(_latitude, _longitude);

  @override
  String toString() {
    return 'Latitude: $latitude\n'
        'Longitude: $longitude\n'
        'Address: $address\n';
  }
}

//what does a place have
class Place {
  final int _id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place(
      {required int id,
      required this.title,
      required this.location,
      required this.image})
      : _id = id;

  Map<String, Object> toJSON() {
    return {
      'title': title,
      'imagePath': image.path,
      'latitude': location.latitude,
      'longitude': location.longitude
    };
  }

  int get id => _id;

  @override
  String toString() {
    return 'Id: $id\n'
        'Title: $title\n'
        'Location: $location\n';
  }
}
