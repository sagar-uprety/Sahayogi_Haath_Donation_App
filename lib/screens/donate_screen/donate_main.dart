import 'package:flutter/material.dart';
import 'package:sahayogihaath/components/RoundedButton.dart';
import '../../theme/extention.dart';
import 'package:esewa_pnp/esewa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:esewa_pnp/esewa_pnp.dart';

enum medium { eSewa, khalti }

class DonateScreen extends StatefulWidget {
  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  ESewaPnp _esewaPnp;
  ESewaConfiguration _configuration;
  int _amount = 0;
  String _orgName = '';
  String _referenceID = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _configuration = ESewaConfiguration(
      clientID: "NhINFhgcDAxZLRIEAwlTLwoXBAcMGA9JJTVUICBIJCA7Kjw2Ijo=",
      secretKey: "NhINFhgcDAxZLRIEAwk=",
      environment: ESewaConfiguration.ENVIRONMENT_TEST,
    );
    _esewaPnp = ESewaPnp(configuration: _configuration);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(65, 161, 36, 1),
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("ESewa PNP"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _amount = int.parse(value);
                  });
                },
                decoration: InputDecoration(
                  labelText: "Enter amount",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Color.fromRGBO(65, 161, 36, 1),
                  onPressed: () {
                    pay();
                  },
                  child: Text(
                    "Pay",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 84,
              ),
              Text(_orgName),
              Text(_referenceID),
              RaisedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: Text('Logout'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pay() async {
    ESewaPayment eSewaPayment = ESewaPayment(
      amount: _amount,
      productName: "Org Test 1",
      productID: "abc123001",
      callBackURL: "https://www.sagaruprety.com.np",
    );
    try {
      final res = await _esewaPnp.initPayment(payment: eSewaPayment);
      setState(() {
        _orgName = res.date;
        _referenceID = res.referenceId;
      });
      _scaffoldKey.currentState.showSnackBar(
          _buildSnackBar(Color.fromRGBO(65, 161, 36, 1), res.message));
    } on ESewaPaymentException catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(_buildSnackBar(Colors.red, e.message));
    }
  }

  Widget _buildSnackBar(Color color, String msg) {
    return SnackBar(
      backgroundColor: color,
      content: Text(msg),
    );
  }
}
