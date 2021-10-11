import 'dart:io';

class Location {
  final double latitude;
  final double longtitude;
  final String? address;

  Location({
    required this.latitude,
    required this.longtitude,
    this.address,
  });

  @override
  String toString() {
    return super.toString();
  }
}

//what does a place have
class Place {
  final String id;
  final String title;
  final Location location;
  final File image;

  Place(
      {required this.id,
      required this.title,
      required this.location,
      required this.image});

  @override
  String toString() {
    return super.toString();
  }
}
