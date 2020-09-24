import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sahayogihaath/components/RoundedButton.dart';
import 'package:esewa_pnp/esewa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:provider/provider.dart';
import 'package:sahayogihaath/models/extras_model.dart';
import 'package:sahayogihaath/models/usermodel.dart';
import 'package:sahayogihaath/models/usertransactionmodel.dart';
import 'package:sahayogihaath/provider/extras_provider.dart';

import '../../routes.dart';
import '../../components/AppBars/appBar.dart';

import '../../provider/user_provider.dart';
import '../../provider/usertransaction_provider.dart';

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
  ComboModel passedOrganization;

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
    passedOrganization = ModalRoute.of(context).settings.arguments;

    print(passedOrganization);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(65, 161, 36, 1),
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: GlobalAppBar(),
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pay() async {
    ESewaPayment eSewaPayment = ESewaPayment(
      amount: _amount,
      productName: passedOrganization.organization.name,
      productID: passedOrganization.organization.id,
      callBackURL: "https://www.sagaruprety.com.np",
    );
    try {
      final res = await _esewaPnp.initPayment(payment: eSewaPayment);
      updateFirestore(res);
      print(res.referenceId);
      Navigator.pushReplacementNamed(context, Routes.donate_success,
          arguments: res);
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

  Future<void> updateFirestore(ESewaResult res) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    final ESewaResult response = res;
    final double amount = double.parse(response.totalAmount);
    UserTransactionModel newTransaction = UserTransactionModel(
        transactionId: response.referenceId,
        donorId: user.id,
        donor: user.name,
        donorImage: user.profileImage,
        doneeId: passedOrganization.organization.id,
        donee: passedOrganization.organization.name,
        doneeImage: passedOrganization.organization.profileImage,
        amount: amount,
        time: Timestamp.fromDate(DateTime.now()));

    final transactionProvider =
        Provider.of<UserTransactionProvider>(context, listen: false);

    await transactionProvider.saveTransaction(newTransaction,
        id: response.referenceId);

    final extra = Provider.of<ExtrasProvider>(context, listen: false);
    extra.changeAmount(amount);
    extra.saveAmountandCount();

    extra.saveAmountandCountOrg(
      passedOrganization.organizationExtra.id,
      updatedAmount:
          passedOrganization.organizationExtra.receivedAmount + amount,
      updatedCount: passedOrganization.organizationExtra.countDonation + 1,
    );
  }
}
