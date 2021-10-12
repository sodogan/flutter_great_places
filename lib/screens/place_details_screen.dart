import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = '/place_dtls';
  const PlaceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Details'),
      ),
      body: Center(
        child: Text('Inside the details'),
      ),
    );
  }
}
