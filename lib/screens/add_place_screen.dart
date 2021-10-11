import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_great_places/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _NewPlaceScreenState createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _titleOfthePlace;
  File? _imagePreview;

  void addNewPlace() {
    //Validate the form
    if (!_formKey.currentState!.validate()) return;

    //call save
    _formKey.currentState!.save();

    //Make sure that picture is taken

    //Make sure that location is chosen

    //Go on adding new place
  }

  void takePhoto() {}
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
                    const ImageInput(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                      ),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text('Map Preview'),
                        ),
                        width: double.infinity,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: addNewPlace,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: const Text(
                              'Pick a Place',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: addNewPlace,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: const Text(
                              'Use Location',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          AddPlaceButton(addNewPlace: addNewPlace)
        ],
      ),
    );
  }
}

class AddPlaceButton extends StatelessWidget {
  final Function addNewPlace;
  const AddPlaceButton({
    Key? key,
    required this.addNewPlace,
  }) : super(key: key);

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
      onPressed: () => addNewPlace(),
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
