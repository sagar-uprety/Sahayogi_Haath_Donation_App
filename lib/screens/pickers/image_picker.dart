import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/activity_provider.dart';
import '../../provider/extras_provider.dart';
import '../../provider/user_provider.dart';
import '../../services/image_upload.dart';

import '../../theme/text_styles.dart';
import '../../theme/theme.dart';

enum ImageType { userProfile, document, activity, banner}

class ImageFilePicker extends StatefulWidget {
  ImageFilePicker(this.imagePickFn, {this.imageType, this.existingImage});

  final void Function(File pickedImage) imagePickFn;

  final ImageType imageType;

  final String existingImage;

  @override
  _ImageFilePickerState createState() => _ImageFilePickerState();
}

class _ImageFilePickerState extends State<ImageFilePicker> {
  File _pickedImage;

  bool isLoading = true;

  @override
  void initState() {
    if (widget.existingImage != null) {
      ConvertUrl().urlToFile(widget.existingImage).then((value) {
        setState(() {
          _pickedImage = value;
          isLoading = false;
        });
      });
    } else {
      isLoading = false;
    }

    super.initState();
  }

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

    if (widget.imageType == ImageType.activity) {
      final activityProvider =
          Provider.of<ActivityProvider>(context, listen: false);

      activityProvider.changeImage(pickedImageFile);
    }

    if (widget.imageType == ImageType.userProfile) {
      if(widget.existingImage != null){
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.changeProfileImage(pickedImageFile);
      }
    }

    if (widget.imageType == ImageType.banner) {
      final userProvider = Provider.of<ExtrasProvider>(context, listen: false);
      userProvider.changeBannerImage(pickedImageFile);
    }

    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : Column(
            children: <Widget>[
              if (widget.imageType == ImageType.userProfile)
                _userImage(context),
              if (widget.imageType == ImageType.document)
                _documentImage(context),
              if (widget.imageType == ImageType.activity)
                _activityImage(context),
              if (widget.imageType == ImageType.banner)
                _bannerImage(context),
              FlatButton.icon(
                textColor: Theme.of(context).primaryColor,
                onPressed: _pickImage,
                icon: Icon(_pickedImage == null
                    ? Icons.add_photo_alternate
                    : Icons.image),
                label:
                    Text(_pickedImage == null ? 'Add Image' : 'Change Image'),
              ),
            ],
          );
  }

  Widget _userImage(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Theme.of(context).primaryColor,
      backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
    );
  }

  Widget _documentImage(BuildContext context) {
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
          height: AppTheme.fullWidth(context) * 0.012,
        ),
        Container(
          height:
              _pickedImage != null ? AppTheme.fullHeight(context) * 0.196 : 0,
          width: _pickedImage != null ? AppTheme.fullWidth(context) * 0.28 : 0,
          decoration: BoxDecoration(
            image: _pickedImage != null
                ? DecorationImage(
                    image: FileImage(_pickedImage), fit: BoxFit.cover)
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  Widget _activityImage(BuildContext context) {
    return Container(
      height: _pickedImage != null ? AppTheme.fullHeight(context) * 0.30 : 0,
      width: _pickedImage != null ? AppTheme.fullWidth(context) * 0.90 : 0,
      decoration: BoxDecoration(
        image: _pickedImage != null
            ? DecorationImage(image: FileImage(_pickedImage), fit: BoxFit.cover)
            : null,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _bannerImage(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Add a banner to display on your profile.',
            textAlign: TextAlign.center,
            style: TextStyles.bodySm,
          ),
        ),
        SizedBox(
          height: AppTheme.fullWidth(context) * 0.012,
        ),
        Container(
          height: _pickedImage != null ? AppTheme.fullHeight(context) * 0.50 : 0,
          width: _pickedImage != null ? AppTheme.fullWidth(context) * 0.90 : 0,
          decoration: BoxDecoration(
            image: _pickedImage != null
                ? DecorationImage(image: FileImage(_pickedImage), fit: BoxFit.cover)
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
