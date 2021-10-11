import 'package:flutter/material.dart';
import 'add_place_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places_list.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  void addNewPlace(BuildContext context) {
    //Go to the New place screen
    Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlacesList(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => addNewPlace(context),
            )
          ],
        ),
        body: Center(
          child: Text('Great Places List'),
        ),
      ),
    );
  }
}
