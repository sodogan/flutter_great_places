import 'package:flutter/material.dart';
import 'package:flutter_great_places/model/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../utility/location_helper.dart';

class PickLocationScreen extends StatefulWidget {
  final PlaceLocation? _initialLocation;

  const PickLocationScreen({
    Key? key,
    PlaceLocation? locationPicked,
  })  : _initialLocation = locationPicked ?? const PlaceLocation.none(),
        super(key: key);

  @override
  _PickLocationScreen createState() => _PickLocationScreen();
}

class _PickLocationScreen extends State<PickLocationScreen> {
  LatLng? _pickedLocation;

  void pickLocationfromMap(LatLng location) {
    setState(() {
      _pickedLocation = location;
    });
  }

  void saveLocation() async {
    //will pop the data and return the location back
    if (_pickedLocation == null) {
      return;
    }
    //get the address
    final _address = await LocationHelper.getAddressFromLatLng(
        latitude: _pickedLocation!.latitude,
        longitude: _pickedLocation!.longitude);

    final _pickedPlaceLocation = PlaceLocation(
        latitude: _pickedLocation!.latitude,
        longtitude: _pickedLocation!.longitude,
        address: _address);
    Navigator.of(context).pop(_pickedPlaceLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _pickedLocation != null ? saveLocation : null,
            icon: const Icon(Icons.check),
          )
        ],
        title: const Text('Pick Your Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget._initialLocation!.toLatLng,
          zoom: 16,
        ),
        onTap: pickLocationfromMap,
        markers: <Marker>{
          if (_pickedLocation == null)
            Marker(
              markerId: const MarkerId('a1'),
              position: widget._initialLocation!.toLatLng,
              infoWindow: const InfoWindow(title: 'GooglePlex'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure,
              ),
            )
          else
            Marker(markerId: const MarkerId('b1'), position: _pickedLocation!)
        },
      ),
    );
  }
}
