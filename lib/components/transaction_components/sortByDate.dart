import 'package:flutter/material.dart';
class SortByList extends StatelessWidget {
  const SortByList({
    Key key,
    @required this.queryData,
  }) : super(key: key);

  final MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Sort by:'),
        SizedBox(
          width: queryData.size.width*0.05,
        ),
        Container(
          width: queryData.size.width*0.35,
          alignment: Alignment.center,
          height: queryData.size.height*0.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              width: 1,
              color: Color(0xFFA6AAB4),
            ),
            color: Color(0x22A6AAB4),
          ),
            child: Center(
              child: DropdownButton<String>(
                isExpanded: false,
                underline:SizedBox(),
                items: [
                  DropdownMenuItem(child: Text('Date',),),
                  DropdownMenuItem(child: Text('Week',),),
                  DropdownMenuItem(child: Text('Month',),),
                ],
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black),
                onChanged: (value){
                  print(value);
                },
              ),
            ),
          ),
      ],
    );
  }
}