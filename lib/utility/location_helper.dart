import 'dart:convert';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  static const GOOGLE_API_KEY = 'AIzaSyA4lPLtfRGxN2WB6pzmN3yhSubhwxYZAxE';
  static const GOOGLE_MAPS_BASE_URL =
      'https://maps.googleapis.com/maps/api/staticmap?center=';

//dynamically generate the Image via GOOGLE Static Maps
//Using the Static MAps API -Google
  static String generateLocationImagePreview({
    required double latitude,
    required double longitude,
  }) {
    final _previewURL =
        '$GOOGLE_MAPS_BASE_URL&$latitude,$longitude&zoom=16&size=800x600&&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
    return _previewURL;
  }

  static Future<String> getCurrentLocationOnMap() async {
    //get the current location
    final _data = await Location().getLocation();

    final _url = generateLocationImagePreview(
        latitude: _data.latitude!, longitude: _data.longitude!);
    print(_url);
    return _url;
  }

//using the GEoCoding API- Reverse Look up-address look up
  static Future<String> getAddressFromLatLng({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final _response = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY'),
      );
      final result = jsonDecode(_response.body);
      //Need to get the data from it
      final _transformed = result['results'] as List<dynamic>;
      // print(_transformed);
      final _formattedAddress = _transformed[0]['formatted_address'];
      print(_formattedAddress);
      return _formattedAddress;
    } catch (err) {
      rethrow;
    }
  }
}
