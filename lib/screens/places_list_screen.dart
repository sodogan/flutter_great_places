import 'package:flutter/material.dart';
import 'package:flutter_great_places/screens/place_details_screen.dart';
import 'package:flutter_great_places/widgets/place_item.dart';
import 'add_place_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places_list.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);
  /*
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      //fetch the data
      Provider.of<GreatPlacesList>(context, listen: false)
          .fetchAndSetPlaces()
          .then((value) => null)
          .catchError(
            (onError) => print(onError),
          );
    });
  }
*/
  void addNewPlace(BuildContext context) {
    //Go to the New place screen
    Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
  }

  void navigateToDetails(BuildContext context) {}

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
      body: FutureBuilder(
        //Delay for 2 seconds to see the spinner
        future: Future.delayed(
            const Duration(
              seconds: 2,
            ), () async {
          final _provider = Provider.of<GreatPlacesList>(
            context,
            listen: false,
          );
          await _provider.fetchAndSetPlaces();
        }),
        builder: (cntx, asyncSnapshot) {
          return asyncSnapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.amber,
                ))
              : Consumer<GreatPlacesList>(
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
                                final _place = _placesList[index];
                                return PlaceItem(
                                  place: _place,
                                  onNavigateToDetail: (context) {
                                    Navigator.of(context).pushNamed(
                                        PlaceDetailsScreen.routeName,
                                        arguments: {'id': _place.id});
                                  },
                                  onDeletePlace: (int index) {
                                    //delete the place
                                    placeListProvider.deletePlace(index: index);
                                  },
                                  index: index,
                                );
                              },
                              itemCount: _placesList.length,
                            ),
                          );
                  },
                );
        },
      ),
    );
  }
}
