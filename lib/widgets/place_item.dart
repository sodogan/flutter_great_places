import 'package:flutter/material.dart';
import 'package:flutter_great_places/model/place.dart';

class PlaceItem extends StatelessWidget {
  final Place _place;
  final Function onNavigateToDetail;

  const PlaceItem({
    Key? key,
    required Place place,
    required this.onNavigateToDetail,
  })  : _place = place,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: FileImage(
          _place.image,
        ),
      ),
      title: Text(_place.title),
      subtitle: Text(
        _place.location.toString(),
      ),
      onTap: () => onNavigateToDetail(context),
      /*
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _onDeletePlace(
                              placeListProvider: placeListProvider,
                              index: index),
                        ),
                        */
    );
  }
}
