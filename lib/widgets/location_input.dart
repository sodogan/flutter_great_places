import 'package:flutter/material.dart';
import 'package:flutter_great_places/model/place.dart';
import 'package:flutter_great_places/utility/location_helper.dart';
import '../utility/location_helper.dart';
import '../screens/pick_location_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectLocation;

  const LocationInput({
    Key? key,
    required this.onSelectLocation,
  }) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _locationImageURL;
  PlaceLocation? _locationPicked;

  void getCurrentLocation() async {
    //get the current location
    final LocationData _locationData = await Location().getLocation();

    final _previewMapURL = LocationHelper.generateLocationImagePreview(
        latitude: _locationData.latitude!, longitude: _locationData.longitude!);

    //get the address
    final _address = await LocationHelper.getAddressFromLatLng(
        latitude: _locationData.latitude!, longitude: _locationData.longitude!);

    setState(() {
      _locationImageURL = _previewMapURL;
    });
    widget.onSelectLocation(
      location: PlaceLocation(
          latitude: _locationData.latitude!,
          longtitude: _locationData.longitude!,
          address: _address),
    );
  }

  void pickLocationFromMap() async {
    //Need to go to Map into PickLocation screen
    final PlaceLocation _location = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return const PickLocationScreen();
        },
      ),
    );

    setState(() {
      _locationPicked = _location;
      _locationImageURL = LocationHelper.generateLocationImagePreview(
        latitude: _locationPicked!.latitude,
        longitude: _locationPicked!.longitude,
      );
    });

    widget.onSelectLocation(location: _locationPicked);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
          ),
          child: Container(
            height: 170,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: _locationImageURL == null
                ? const Text(
                    'No Location chosen',
                    textAlign: TextAlign.center,
                  )
                : Image.network(
                    _locationImageURL!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
            width: double.infinity,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              onPressed: getCurrentLocation,
              label: const Text(
                'Current Location',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.map_rounded),
              onPressed: pickLocationFromMap,
              label: const Text(
                'Select on Map',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
