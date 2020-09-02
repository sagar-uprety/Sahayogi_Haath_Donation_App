import 'package:flutter/material.dart';
import '../theme/light_color.dart';
import '../screens/organization/exploreorg.dart';

class CategorieTile extends StatefulWidget {
  final String category;
  final bool isSelected;
  final context;
  CategorieTile({this.category, this.isSelected, this.context});

  @override
  _CategorieTileState createState() => _CategorieTileState();
}

class _CategorieTileState extends State<CategorieTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.context.setState(() {
          selectedCategory = widget.category;
          print(selectedCategory);
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(left: 8),
        height: 30,
        decoration: BoxDecoration(
            color: widget.isSelected ? LightColor.purpleLight : Colors.white,
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          widget.category,
          style: TextStyle(
              color: widget.isSelected ? Colors.white : Color(0xffA1A1A1)),
        ),
      ),
    );
  }
}
