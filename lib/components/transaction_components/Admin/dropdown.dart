import 'package:flutter/material.dart';
class OrganizationName extends StatelessWidget {
  const OrganizationName({
    Key key,
    @required this.queryData,
  }) : super(key: key);
  
  final MediaQueryData queryData;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: queryData.size.width*0.5,
      alignment: Alignment.center,
      height: queryData.size.height*0.07,
      margin: EdgeInsets.symmetric(horizontal:50, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
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
            DropdownMenuItem(child: Text('Helping Hand',),)
          ],
          style: TextStyle(
            fontSize: 18,
            color: Colors.black),
          onChanged: (value){
            print(value);
          },
        ),
      ),
    );
  }
}