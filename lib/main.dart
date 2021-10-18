import 'package:flutter/material.dart';
import 'package:flutter_great_places/screens/place_details_screen.dart';
import 'screens/places_list_screen.dart';
import 'screens/add_place_screen.dart';
import 'package:provider/provider.dart';
import './providers/great_places_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlacesList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: Colors.purple),
          ),
          primarySwatch: Colors.indigo,
        ),
        // home: const GreatPlacesOverviewScreen(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => const PlacesListScreen(),
          AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen(),
          PlaceDetailsScreen.routeName: (ctx) => PlaceDetailsScreen()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
