import 'package:flutter/material.dart';
import 'package:flutter_great_places/model/place.dart';
import 'package:flutter_great_places/providers/great_places_list.dart';
import 'dart:io';

import 'package:flutter_great_places/widgets/image_input.dart';
import 'package:flutter_great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _NewPlaceScreenState createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _titleOfthePlace;
  File? _imageSelected;
  PlaceLocation? _locationSelected;

  bool isValid() {
    if (!_formKey.currentState!.validate() ||
        _imageSelected == null ||
        _locationSelected == null) {
      return false;
    }

    return true;
  }

  void addNewPlace() {
    //Validate the form
    if (!isValid()) {
      return;
    }

    //call save
    _formKey.currentState!.save();

    //Go on adding new place
    final placeListProvider =
        Provider.of<GreatPlacesList>(context, listen: false);
    placeListProvider.addNewPlace(
        pickedTitle: _titleOfthePlace!,
        pickedImage: _imageSelected!,
        pickedLocation: _locationSelected!);
    Navigator.of(context).pop();
  }

  void onSelectImage({required File imagePicked}) {
    _imageSelected = imagePicked;
  }

  void onSelectLocation({required PlaceLocation location}) {
    _locationSelected = location;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            //height: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            label: Text('Title'),
                            hintText: 'Title of the Place'),
                        validator: (value) {
                          return value == null || value.isEmpty
                              ? 'Please enter a title'
                              : null;
                        },
                        onSaved: (String? value) {
                          _titleOfthePlace = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    ImageInput(onSelectImageHandler: onSelectImage),
                    LocationInput(onSelectLocation: onSelectLocation),
                  ],
                ),
              ),
            ),
          ),
          AddPlaceButton(
            addNewPlace: addNewPlace,
            isValid: isValid(),
          )
        ],
      ),
    );
  }
}

class AddPlaceButton extends StatelessWidget {
  final Function addNewPlace;
  final bool isValid;

  const AddPlaceButton(
      {Key? key, required this.addNewPlace, required this.isValid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.grey.shade400,
        ),
      ),
      icon: Icon(
        Icons.add,
        size: 35,
      ),
      onPressed: isValid ? () => addNewPlace() : null,
      label: Text(
        'Add Place',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
