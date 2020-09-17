import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/RoundedButton.dart';

import '../../provider/auth_provider.dart';
import '../../provider/user_provider.dart';
import '../../provider/usertransaction_provider.dart';

import '../dashboard/header.dart';
import './edit_data_field.dart';

import '../../theme/text_styles.dart';
import '../../theme/extention.dart';
import '../../routes.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final transactionProvider = Provider.of<UserTransactionProvider>(context);
    final _auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(user.name, style: TextStyles.h1Style),
                SizedBox(height: 15,),
                Header(),
                if(user.isOrganization)
                  DescriptionSection(),
              ]),
              Column(children: [
                NavigatingButton(
                  text: 'My Donations',
                  onPress: () {
                    String userId = user.id;
                    transactionProvider.getUserName(userId);
                    Navigator.pushNamed(context, Routes.user_transaction);
                    print('My Donations');
                  },
                  icon: Icons.account_balance_wallet,
                ),
                NavigatingButton(
                  text: 'Edit Profile',
                  onPress: () {
                    Navigator.pushNamed(context, Routes.editData);
                  },
                  icon: Icons.edit,
                ),
                NavigatingButton(
                    text: 'Help and Support',
                    onPress: () {
                      print('Help and Suppoort');
                    },
                    icon: Icons.help),
                NavigatingButton(
                    text: 'Terms and Services',
                    onPress: () {
                      print('Terms and Services');
                    },
                    icon: Icons.assignment),
                NavigatingButton(
                  text: 'Logout',
                  onPress: ()async {
                    await _auth.signOut();
                  },
                  icon: Icons.exit_to_app,
                  hasNavigation: false,
                ),
              ])
            ],
          ),
        ),
      ).p16,
    );
  }
}

