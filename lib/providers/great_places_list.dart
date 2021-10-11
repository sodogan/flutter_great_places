import 'dart:collection';

import 'package:flutter/cupertino.dart';
import '../model/place.dart';

class GreatPlacesList with ChangeNotifier {
  List<Place> _placesList = [];

//addPlace
  addPlace() {
    notifyListeners();
  }

//removePlace
  removePlace() {
    notifyListeners();
  }

//should be atomic
  UnmodifiableListView<Place> get placesList =>
      UnmodifiableListView(_placesList);
}
