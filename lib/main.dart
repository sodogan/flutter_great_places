import 'package:flutter/material.dart';
import 'screens/places_list_screen.dart';
import 'screens/add_place_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
