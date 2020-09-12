import 'usertransaction_main.dart';
import '../../components/transaction_components/search_bar.dart';
import '../../components/transaction_components/showtransactionButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/user_provider.dart';
import '../../provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum MyChoice {
  my,
  all,
}

class UserTransaction extends StatefulWidget {
  static const id = 'usertransaction';
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  MyChoice selectedChoice;
  UserProvider user;
  bool isLoading = true;

  @override
  void initState() {
    getUserData().then((value) {
      print("SuccessFul");
    });
    selectedChoice = MyChoice.all;
    

    super.initState();
  }
  getUserData() async {
    final user = Provider.of<UserProvider>(context, listen: false);
    await user.getUserData();
  }
  
  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context);
    MediaQueryData queryData = MediaQuery.of(context);
    double width = queryData.size.width*0.02;
     return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(width),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
               SearchBar(),
                SizedBox(
                    height:MediaQuery.of(context).size.height*0.015,
                  ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ShowTransactionButton(
                        onpressed: (){
                          setState(() {
                          selectedChoice = MyChoice.my;
                          });
                        },
                        text: 'My',
                        colour: selectedChoice == MyChoice.my ? Color(0xFFC4C4C4) : Colors.white,
                        fontcolour: selectedChoice == MyChoice.my ? Colors.white : Colors.black,
                        leftSide: 6,
                        rightSide: 0,
                      ),
                      ShowTransactionButton(
                        onpressed: (){
                          setState(() {
                            selectedChoice = MyChoice.all;
                          });
                          
                        },
                        text: 'All',
                        colour: selectedChoice == MyChoice.all ? Color(0xFFC4C4C4) : Colors.white,
                        fontcolour: selectedChoice == MyChoice.all ? Colors.white : Colors.black,
                        rightSide: 6,
                        leftSide: 0,
                      ),
                      
                    ],
                  )
                ),
                SizedBox(
                    height:MediaQuery.of(context).size.height*0.015,
                  ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: width ),
                    child: UserDonationStream(
                      stateChoice: selectedChoice,
                      userName: user.name,
                      userImage: user.profileImage,
                    )
                  ),  
              ]
            ),
          ),
        ),
      ),
    );
  }
}









