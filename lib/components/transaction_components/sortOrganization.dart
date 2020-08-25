import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class OrganizationName extends StatelessWidget {
  const OrganizationName({
    Key key,
    @required this.queryData,
  }) : super(key: key);
  
  final MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('transaction').orderBy('dateTime').snapshots(),
        builder: (BuildContext, snapshot){
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'),);
                  }
                  if (!snapshot.hasData) {
                    return  Text('Loading');
                  }
       
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
        child: DropdownButton(
          hint: Text('All Transaction'),
          isExpanded: false,
          underline:SizedBox(),
          items: snapshot.data.documents.map((DocumentSnapshot document){
            return DropdownMenuItem (
              value: document.data['donee'],
              child: Container(
                child: Text(document.data['donee'],style: TextStyle(
                fontSize: 18,
                  color: Colors.black),),
              ),
            );
          }).toList(),
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
    );
  }
}