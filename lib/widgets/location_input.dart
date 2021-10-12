import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectLocation;

  LocationInput({Key? key, required this.onSelectLocation}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () => widget.onSelectLocation(),
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
          onPressed: () => widget.onSelectLocation(),
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
    );
  }
}
