import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  File _imageController;
  final Function onselectImage;

  ImageInput(this.onselectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  Future<void> imagePicker() async {
    final picker = ImagePicker();
    final imagePicker =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (imagePicker == null) {
      return;
    }

    setState(() {
      widget._imageController = File(imagePicker.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imagePicker.path);
    final savedImage =
        await widget._imageController.copy('${appDir.path}/$fileName');
    widget.onselectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: widget._imageController != null
            ? Image.file(
                widget._imageController,
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : Text(
                'Image not found!',
                textAlign: TextAlign.center,
              ),
        alignment: Alignment.center,
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: FlatButton.icon(
          onPressed: imagePicker,
          icon: Icon(Icons.camera),
          label: Text(
            'Open your Camera',
          ),
        ),
      )
    ]);
  }
}
