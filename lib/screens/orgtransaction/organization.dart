import 'package:date_range_picker/date_range_picker.dart' as dateRange;
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/transaction_components/search_bar.dart';
import 'organization_main.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class OrganizationTransaction extends StatefulWidget {
  static const id = 'organizationtransaction';
  @override
   _OrganizationTransaction createState() =>  _OrganizationTransaction();
}
DateTime current = DateTime.now();
DateTime selecteddate;
DateTime endDate;
class  _OrganizationTransaction extends State< OrganizationTransaction> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
 
  DateTime getStartDate(DateTime date){
    selecteddate = date;
    return selecteddate;
  } 
  DateTime getEndDate(DateTime dateTime){
     if(dateTime != null){
        endDate = DateTime(dateTime.year, dateTime.month,dateTime.day, 24, 59, 59);
      }
  }
  Future selectdateRange(BuildContext context) async{
    selecteddate = DateTime(current.year, current.month,current.day);
    endDate = DateTime(current.year, current.month, current.day).add(Duration(days: 7));
   final List <DateTime> pickedDateRange = await dateRange.showDatePicker(
     context: context,
     initialFirstDate: selecteddate ,
     initialLastDate: endDate,
      firstDate: DateTime(2009), 
      lastDate: DateTime(2021)
    );
    if (pickedDateRange!=null && pickedDateRange.length==2 ){
      setState(() {
         selecteddate = pickedDateRange[0];
          endDate = pickedDateRange[1];
          getEndDate(endDate);
      });
     
    }
  }
  Future <dynamic> selectdate(BuildContext context) async{
    
    DateTime selectedDate = DateTime(current.year, current.month, current.day,current.hour,current.minute);
    final DateTime pickedDate = await showDatePicker(
        context: context, 
        initialDate: selectedDate, 
        firstDate: DateTime(2009), 
        lastDate: DateTime(2021),
      );
      if(pickedDate != null && pickedDate != selectedDate){
        setState(() {
          selectedDate = pickedDate;
          getStartDate(selectedDate);
          getEndDate(selecteddate);
        });
      
      }
  }
   getSorted(String selectedValue){
    if(selectedValue == 'Date'){
      selectdate(context);
  }
  else if(selectedValue == 'Range'){
    selectdateRange(context);
  }
  }
  
  void getCurrentUser() async{
    try{
      final user=await _auth.currentUser();

      if(user != null){
        loggedInUser=user;
      }
    }
    catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  List <String> sortByData = [
    'Date',
    'Range'
  ];
  String selectedValue;
  DropdownButton sortBy(){
    List <DropdownMenuItem> sortList = [];
    for(var data in sortByData){
      String by = data;
      var sort = DropdownMenuItem(
        child: Text(by),
        value: by,
      );
      sortList.add(sort);
    }
    return DropdownButton (
                hint: Text('Select'),
                value: selectedValue,
                isExpanded: false,
                underline:SizedBox(),
                items: sortList,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black),
                onChanged: (value){
                  setState(() {
                    selectedValue = value;
                    getSorted(selectedValue);
                  });
                 
                },
              );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double width = queryData.size.width*0.02;
     return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(width),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                SearchBar(),
                SizedBox(
                  height:MediaQuery.of(context).size.height*0.015,
                ),
                 Row(
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
              child: sortBy(),
            ),
          ),
      ],
    ),
                SizedBox(
                  height:MediaQuery.of(context).size.height*0.015,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width ),
                  child: OrgDonationStream(
                    startDate: selecteddate, 
                    endDate: endDate,

                  ),
                ),  
              ]
            ),
          ),
        ),
      ),
    );
  }
}









