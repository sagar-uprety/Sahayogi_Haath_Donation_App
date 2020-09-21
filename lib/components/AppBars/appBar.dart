import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahayogihaath/routes.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  GlobalAppBar({
    this.bottom,
  }) : preferredSize = Size.fromHeight(56 + (bottom?.preferredSize?.height ?? 0.0));
  final TabBar bottom;
  final Size preferredSize;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0.0,
      leading: BackButton(color: Colors.black),
      bottom: bottom,
    );
  }
}

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget{
  DashboardAppBar({this.bottom}) : preferredSize = Size.fromHeight(56 + (bottom?.preferredSize?.height ?? 0.0));
  final Size preferredSize;
  final bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.short_text,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.profile);
            }),
      ],
    );
  }
}