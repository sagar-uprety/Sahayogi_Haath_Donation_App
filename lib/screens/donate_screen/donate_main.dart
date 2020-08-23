import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/components/RoundedButton.dart';
import 'package:sahayogihaath/provider_/auth_provider.dart';
import '../../theme/extention.dart';

enum medium { eSewa, khalti }

class DonateScreen extends StatefulWidget {
  static const id = "donate_screen";
  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  int donateAmount;
  DateTime date;
  String username;
  String selectedmedium;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    donateAmount = int.parse(value);
                  });
                },
              ),
              DropdownButtonFormField(
                  items: [
                    DropdownMenuItem(
                      value: medium.eSewa,
                      child: Text("eSewa"),
                    ),
                    DropdownMenuItem(
                      value: medium.khalti,
                      child: Text("Khalti"),
                    )
                  ],
                  onChanged: (value) {
                    selectedmedium = value;
                    print(value);
                  }),
              RoundButton(
                text: "Donate Rs.${donateAmount.toString()} ",
                onPress: () {
                  _formKey.currentState.save();
                  print(selectedmedium.toString());
                  print(donateAmount);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0XFFfefefe), //manage all theme color
      leading: BackButton(color: Theme.of(context).primaryColor),
      actions: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: Image.asset(
              "assets/images1/janko.jpg", //user profile image
              fit: BoxFit.fill,
            ),
          ),
        ).p(9),
      ],
    );
  }
}
