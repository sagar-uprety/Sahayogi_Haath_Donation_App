import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_khalti/flutter_khalti.dart';

class Dashboard extends StatelessWidget {
  static const id = 'dashboard';
  initPayment() {
  FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
    publicKey: "test_public_key_eacadfb91994475d8bebfa577b0bca68",
     urlSchemeIOS: "KhaltiPayFlutterExampleScheme",
     paymentPreferences: [
        KhaltiPaymentPreference.KHALTI,
      ],
  );

  KhaltiProduct product = KhaltiProduct(
    amount: 50,
    id: "test",
    name: "test1"
  );

  _flutterKhalti.startPayment(
    product: product,
    onSuccess: (data){
      print("here");
    },
    onFaliure: (error){
      print("sorry");
    },
  );

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                'Dashboard',
              ),
            ),
          ),
          RaisedButton(
            onPressed: () async{
               initPayment();
            },
          ),
          RaisedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Text('Logout'),
          )
        ],
      ),
    );
  }
}

