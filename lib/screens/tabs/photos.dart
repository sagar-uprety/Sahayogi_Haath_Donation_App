import 'package:flutter/material.dart';

class PhotosSection extends StatefulWidget {
  @override
  _PhotosSectionState createState() => _PhotosSectionState();
}

class _PhotosSectionState extends State<PhotosSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      child: Text(
        "Photos",
      ),
      
    );
  }
}