import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sahayogi Haath'),
        ),
        body: Container(
          child: Center(
            child: Text(
              'Sahayogi Haath is the best app',
            ),
          ),
        ),
      ),
    );
  }
}
