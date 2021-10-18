import 'package:flutter/material.dart';
import 'package:flutter_great_places/providers/great_places_list.dart';
import 'package:provider/provider.dart';
import '../utility/location_helper.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = '/place_dtls';
  const PlaceDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _args =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    int id = _args['id'] as int;

    //Now lookup the value
    final _selectedPlace =
        Provider.of<GreatPlacesList>(context, listen: false).findPlaceByID(id);

    final locationImageURL = LocationHelper.generateLocationImagePreview(
        latitude: _selectedPlace.location.latitude,
        longitude: _selectedPlace.location.longitude);

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedPlace.title),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                height: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                child: Image.file(
                  _selectedPlace.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                width: double.infinity,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  height: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  child: Image.network(
                    locationImageURL,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  width: double.infinity,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
