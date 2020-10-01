import 'package:flutter/material.dart';
import '../theme/light_color.dart';

class CategoryTile extends StatefulWidget {
  final String category;
  final bool isSelected;
  final context;
  final Function changeCategory;
  CategoryTile({this.category, this.isSelected, this.changeCategory,this.context});

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.changeCategory(widget.category);
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
