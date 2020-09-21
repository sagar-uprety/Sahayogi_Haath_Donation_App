import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as dateRange;

import 'user_transactionmain.dart';

import '../../constants.dart';

import '../../components/transaction_components/search_bar.dart';

import '../../provider/user_provider.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

DateTime current = DateTime.now();
DateTime selecteddate;
DateTime endDate;
String holder;


class _UserTransactionState extends State<UserTransaction> {
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

  String getCurrentData(String orgName){
        holder = orgName;
     return holder;
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
  
 
  List <String> sortByData = [
    'Date',
    'Range'
  ];
  String selectedValue;
  String orgName;
  DropdownButton sortByDate(){
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
                       if(user.isDonor) _user(),
                       if(user.isAdmin) _admin(),
                   ]
                 ),
               ) 
      ),
    )
     );
  }
  
  Widget _user(){
    MediaQueryData queryData = MediaQuery.of(context);
     final user = Provider.of<UserProvider>(context);
    String userid = user.id; 
     return Column(
       children: [
         Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
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
                        child: sortByDate(),
                      ),
                    ),
                ],
              ),
       
        SizedBox(
            height:MediaQuery.of(context).size.height*0.015,
          ),
        UserTransactionMain(userid: userid, selectedDate: selecteddate, endDate: endDate,),
      ],
     );
  }
   Widget _admin(){
     MediaQueryData queryData = MediaQuery.of(context);
     final user = Provider.of<UserProvider>(context);
    String userid = user.id; 
    return  Column(
      children: <Widget>[
      Container(
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
        child: _getOrgName(),
      ),
    ),
                SizedBox(
                    height:MediaQuery.of(context).size.height*0.015,
                  ),
                _info(),
                SizedBox(
                    height:MediaQuery.of(context).size.height*0.015,
                  ),
                  AdminTransactionMain(orgName: holder,)
              
              ]
          );
    
     }
       
  

   Widget _info(){
    final user = Provider.of<UserProvider>(context);
    final userImage = user.profileImage;
    MediaQueryData queryData = MediaQuery.of(context);
    double width = queryData.size.width*0.02;
    double height = queryData.size.width*0.03;
     return Container(
                  margin: EdgeInsets.symmetric(horizontal: width ),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0x66A6AAB4),
              ),
                  padding: EdgeInsets.symmetric(horizontal:width, vertical: height),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column( 
                        children: <Widget>[
                          Text('Rs 1500', style: kAdminTransactionCard,),
                          SizedBox(
                            height: height,
                          ),
                          Text('Total donation'),
                        ]
                      ),
                       Column( 
                        children: <Widget>[
                          Text('3', style: kAdminTransactionCard,),
                          SizedBox(
                            height: height,
                          ),
                          Text('Donations'),
                        ]
                      ),
                      CircleAvatar(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(userImage),
                          radius: 45,
                        ),
                        backgroundColor: Color(0xFFFFFFFF),
                        
                        radius: 50,
                      )
                    ],
                  )
                );
   }

   Widget _getOrgName(){
       MediaQueryData queryData = MediaQuery.of(context);
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('users').where('isOrganization', isEqualTo: true).snapshots(),
        builder: (context, snapshot){
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'),);
                  }
                  if (!snapshot.hasData) {
                    return  Text('Loading');
                  }
                 return DropdownButton (
                    value: orgName,
                      hint: Text('View Transaction'),
                      isExpanded: false,
                      underline:SizedBox(),
                      items: snapshot.data.documents.map((DocumentSnapshot document){
                        return DropdownMenuItem (
                          value: document.data['name'],
                          child: FittedBox(
                            child: Container(
                              child: FittedBox(
                                child: Text(document.data['name'],style: TextStyle(
                                fontSize: 14,
                                  color: Colors.black),),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          orgName = value;
                          getCurrentData(orgName);
                      });
                      },
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black),
                      );
        }
    );
  }
}
