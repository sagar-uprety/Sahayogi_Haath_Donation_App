import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocumentPicker extends StatefulWidget {
  DocumentPicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  _DocumentPickerState createState() => _DocumentPickerState();
}

class _DocumentPickerState extends State<DocumentPicker> {
  File _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      // maxWidth: 200,
    );
    // to convert imageFile of type PickedFile to File
    final File pickedImageFile = File(imageFile.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Add a document image to prove that you are a valid organization.',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: size.height*0.012,
        ),
        Container(
          height: _pickedImage != null ?  size.height*0.196 : 0,
          width: _pickedImage != null ? size.width*0.28 : 0,
          decoration: BoxDecoration(
            image: _pickedImage != null ?  DecorationImage(image:FileImage(_pickedImage),fit: BoxFit.cover) : null,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(_pickedImage == null ? Icons.add_photo_alternate : Icons.image),
          label: Text(_pickedImage == null ? 'Add Image' : 'Change Image'),
        ),
      ],
    );
  }
}
