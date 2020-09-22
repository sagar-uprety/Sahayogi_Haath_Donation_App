import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../provider/user_provider.dart';
import '../../routes.dart';
import '../../theme/text_styles.dart';
import '../../theme/theme.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blue.shade700),
            accountName: Text(
              user.name,
              style: TextStyles.title.copyWith(color: Colors.white),
            ),
            accountEmail: Text(
              user.email,
              style: TextStyles.bodySm
                  .copyWith(color: Colors.white, letterSpacing: 0.5),
            ),
            currentAccountPicture: Center(
              child: CircleAvatar(
                  backgroundImage: NetworkImage(user.profileImage),
                  radius: AppTheme.fullWidth(context) * .10),
            ),
          ),
          Tile(
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () {
              Navigator.pushNamed(context, Routes.dashboard);
            },
          ),
          if (user.isOrganization)
            Tile(
              icon: Icons.person,
              title: 'Profile',
              onTap: () {
                Navigator.pushNamed(context, Routes.org_info);
              },
            ),
          if (user.isDonor)
            Tile(
              icon: Icons.explore,
              title: 'Explore Organizations',
              onTap: () {
                Navigator.pushNamed(context, Routes.explore_org);
              },
            ),
          Tile(
            icon: Icons.account_balance_wallet,
            title: 'Transactions',
            onTap: () {
              print('Transactions');
            },
          ),
          Tile(
            icon: Icons.exit_to_app,
            title: 'Logout',
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false).signOut();
            },
          ),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  Tile({@required this.icon, @required this.title, @required this.onTap});
  final IconData icon;
  final String title;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
