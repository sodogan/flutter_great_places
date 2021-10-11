import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    Key? key,
  }) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  dynamic _pickImageError;

  Future<void> takePhoto() async {
    final _picker = ImagePicker();
    try {
      final _imageFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );
      if (_imageFile != null) {
        final _imageConverted = File(_imageFile.path);
        setState(() {
          _storedImage = _imageConverted;
        });
      }
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
          onPressed: takePhoto,
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
