import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/auth.dart';
import './screens/dashboard.dart';
import './screens/explore.dart';

void main() {
  runApp(SahayogiHaath());
}

class SahayogiHaath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
        title: 'Sahayogi Haath',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF808ef9),
          accentColor: Color(0xFFf1f3f6),
          textTheme: GoogleFonts.sarabunTextTheme(textTheme).copyWith(
            bodyText1: GoogleFonts.lobster(
              textStyle: textTheme.bodyText1,
            ),
            // TODO:set app-wide text theme
          ),
        ),
        initialRoute: Auth.id,
        routes: {
          Auth.id: (ctx) => Auth(),
          Dashboard.id: (ctx) => Dashboard(),
          Explore.id: (ctx) => Explore(),
        });
  }
}
