import 'package:flutter/material.dart';
import 'package:flutter_great_places/screens/place_details_screen.dart';
import 'package:flutter_great_places/widgets/place_item.dart';
import 'add_place_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places_list.dart';

class PlacesListScreen extends StatefulWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  State<PlacesListScreen> createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  @override
  void initState() {
    super.initState();
    //fetch the data

    Provider.of<GreatPlacesList>(context, listen: false)
        .fetchAndSetPlaces()
        .then((value) => null)
        .catchError(
          (onError) => print(onError),
        );
  }

  void addNewPlace(BuildContext context) {
    //Go to the New place screen
    Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
  }

  void navigateToDetails(BuildContext context) {
    Navigator.of(context).pushNamed(PlaceDetailsScreen.routeName);
  }

  void _onDeletePlace(
      {required GreatPlacesList placeListProvider, required int index}) {
    //delete the place
    placeListProvider.removePlace(index: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => addNewPlace(context),
          )
        ],
      ),
      body: Consumer<GreatPlacesList>(
        child: const Center(
          child: Text('No places yet'),
        ),
        builder: (ctx, placeListProvider, chld) {
          final _placesList = placeListProvider.placesList;
          return _placesList.isEmpty
              ? chld!
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return PlaceItem(
                          place: _placesList[index],
                          onNavigateToDetail: navigateToDetails);
                    },
                    itemCount: _placesList.length,
                  ),
                );
        },
      ),
    );
  }
}
