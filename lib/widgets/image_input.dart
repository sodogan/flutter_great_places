import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as hardDrive;
import 'package:path/path.dart' as pathHelper;

class ImageInput extends StatefulWidget {
  final Function onSelectImageHandler;

  const ImageInput({
    Key? key,
    required this.onSelectImageHandler,
  }) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  dynamic _pickImageError;

  Future<void> _takePhoto() async {
    final _picker = ImagePicker();
    try {
      final _imageFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );
      if (_imageFile == null) {
        return;
      }
      final _imageConverted = File(_imageFile.path);
      setState(() {
        _storedImage = _imageConverted;
      });
      //copy the file to the hard drive
      final _directory = await hardDrive.getApplicationDocumentsDirectory();
      String _path = pathHelper.join(
          _directory.path, pathHelper.basename(_imageConverted.path));
      print('Path is $_path');
      final _savedImage = await _imageConverted.copy(_path);
      //call
      widget.onSelectImageHandler(imagePicked: _savedImage);
    } catch (err) {
      print('Error occured $err');
      setState(() {
        _storedImage = null;
      });
      _pickImageError = err;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building ImageInput...');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 150,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage == null
              ? _pickImageError != null
                  ? Text(
                      'Pick image error: $_pickImageError',
                      textAlign: TextAlign.center,
                    )
                  : const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'No image taken yet!',
                        textAlign: TextAlign.center,
                      ),
                    )
              : Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
          alignment: Alignment.center,
        ),
        IconButton(
          icon: const Icon(
            Icons.camera,
            size: 50,
          ),
          onPressed: _takePhoto,
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
