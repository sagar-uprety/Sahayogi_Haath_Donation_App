import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/transaction_const.dart';
import '../../components/transaction_components/search_bar.dart';
import 'admintransaction_main.dart';

import 'package:provider/provider.dart';
import '../../provider/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AdminTransaction extends StatefulWidget {
  static const id = 'admintransaction';
  @override
  _AdminTransactionState createState() => _AdminTransactionState();
}
  
class _AdminTransactionState extends State<AdminTransaction> {  
  UserProvider user;
  bool isLoading = true;
  String userImage;

   final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String orgName;
  String holder ='';
  @override
  void initState() {
    getUserData().then((value) {
      print("SuccessFul");
     
    });
    

    super.initState();
     holder = null;
  }
  getUserData() async {
    try{
      final user = Provider.of<UserProvider>(context, listen: false);
      await user.getUserData();
    }
    catch(e){
      Text('Loading');
    }
  }
  
  
 getCurrentData(String orgName){
        holder = orgName;
     return holder;
  }
  
  @override
  
  Widget build(BuildContext context) {
     user = Provider.of<UserProvider>(context);
      final userImage = user.profileImage;
    MediaQueryData queryData = MediaQuery.of(context);
    double width = queryData.size.width*0.02;
    double height = queryData.size.width*0.03;
     return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
      body: user.name == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
          padding: EdgeInsets.all(width) ,
          child: SingleChildScrollView(
            child:StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('transaction').orderBy('donee').snapshots(),
        builder: (context, snapshot){
                
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'),);
                  }
                  if (!snapshot.hasData) {
                    return  Text('Loading');
                  }
    return              Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                SearchBar(),
                SizedBox(
                    height:MediaQuery.of(context).size.height*0.015,
                ),
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
        child: DropdownButton(
          value: orgName,
          hint: Text('View Transaction'),
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
           onChanged: (value){
              
              setState(() {
                orgName = value;
                getCurrentData(orgName);
              });
               

           
          },
          style: TextStyle(
            fontSize: 18,
            color: Colors.black),
           
        ),
      ),
    ),
                SizedBox(
                    height:MediaQuery.of(context).size.height*0.015,
                  ),
                Container(
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
                         // backgroundColor: Colors.blue,
                          backgroundImage: NetworkImage(userImage),
                          radius: 45,
                        ),
                        backgroundColor: Color(0xFFFFFFFF),
                        
                        radius: 50,
                      )
                    ],
                  )
                ),
                SizedBox(
                    height:MediaQuery.of(context).size.height*0.015,
                  ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width ),
                  child: DonationStream(orgName: holder,),
                ), 
                
              ]
          );
    
     }
    ),

        ),
      ),
      ),
    );
  }
}