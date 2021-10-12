import 'dart:io';

class PlaceLocation {
  final double _latitude;
  final double _longtitude;
  final String? _address;

  PlaceLocation({
    required double latitude,
    required double longtitude,
    String? address,
  })  : _latitude = latitude,
        _longtitude = longtitude,
        _address = address;

  double get latitude => _latitude;
  double get longtitude => _longtitude;
  String? get address => _address;

  @override
  String toString() {
    return 'Latitude: $latitude\n'
        'Lontitude: $longtitude\n'
        'address: $address\n';
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
      'longtitude': location.longtitude
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
