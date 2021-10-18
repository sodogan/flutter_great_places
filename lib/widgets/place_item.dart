import 'package:flutter/material.dart';
import 'package:flutter_great_places/model/place.dart';

class PlaceItem extends StatelessWidget {
  final Place _place;
  final Function onNavigateToDetail;
  final Function _onDeletePlace;
  final int _index;

  const PlaceItem({
    Key? key,
    required Place place,
    required this.onNavigateToDetail,
    required Function onDeletePlace,
    required int index,
  })  : _place = place,
        _onDeletePlace = onDeletePlace,
        _index = index,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: ListTile(
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
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _onDeletePlace(_index),
        ),
      ),
    );
  }
}
