import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as dateRange;
import 'package:sahayogihaath/models/usertransactionmodel.dart';
import 'package:sahayogihaath/provider/usertransaction_provider.dart';
import 'package:sahayogihaath/screens/transaction/user_transactionmain.dart';

import '../../components/transaction_components/search_bar.dart';

import '../../provider/user_provider.dart';

class UserTransaction extends StatefulWidget {
 
  static const id = 'usertransaction';
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

DateTime current = DateTime.now();
DateTime selecteddate;
DateTime endDate;

class _UserTransactionState extends State<UserTransaction> {
   @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    String userid = user.id; 
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
                       // if(user.isDonor);
                      _sortByDate(),
                     SizedBox(
                         height:MediaQuery.of(context).size.height*0.015,
                       ),
                      UserTransactionMain(userid: userid, selectedDate: selecteddate, endDate: endDate,),
                   ]
                 ),
               ) 
      ),
    )
     );
  }
   List <String> sortByData = [
    'Date',
    'Range'
  ];
  String selectedValue;
  
  DateTime getStartDate(DateTime date){
    selecteddate = date;
    return selecteddate;
  } 
  DateTime getEndDate(DateTime dateTime){
     if(dateTime != null){
        endDate = DateTime(dateTime.year, dateTime.month,dateTime.day, 24, 59, 59);
      }
      return endDate;
  }
 
  


  Widget _sortByDate(){
    MediaQueryData queryData = MediaQuery.of(context);
   return Column(
     children: [
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
   );
  }

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
  
   getSorted(String selectedValue){
    if(selectedValue == 'Date'){
      selectdate(context);
  }
  else if(selectedValue == 'Range'){
    selectdateRange(context);
  }
  }


}
