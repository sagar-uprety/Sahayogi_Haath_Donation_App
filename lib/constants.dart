import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF808ef9);
const kPrimaryLightColor = Color(0xFFF1E6FF);

///TextStyles

final tTitleTextStyle= TextStyle(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: Color(0xff171d33)
);

final tOverviewHeadStyle= TextStyle(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
  color: Color(0xff171822),
);

final tOverviewTitleStyle= TextStyle(
  fontWeight: FontWeight.normal,
  fontStyle: FontStyle.normal,
  color: Color(0xff3a4276),
  letterSpacing: 0.96,
);

final tRecentsText1Theme= TextStyle(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.normal,
  color: Color(0xff5e5e5e),
  letterSpacing: 0.2,
);

final tRecentsText2Theme= TextStyle(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.2,
  color: Color(0xff000000),
);

final tRecentsAmountTheme= TextStyle(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.1,
  color: Color(0xfffa2e69),
);

final tSeeMoreTextStyle= TextStyle(
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  fontSize: 16,
  letterSpacing: 0.8,
  color: Color(0xff6979f8),
);

//Containers

final cGreyBoxDecoration= BoxDecoration(
  color: Color(0xffF1F3F6),
  borderRadius: BorderRadius.circular(12.0),
);

final cHomeListContainerDecoration= BoxDecoration(
  color: Color(0xfff8f8f8),
  boxShadow: [BoxShadow(color: Color(0xffffffff),offset: Offset(2, 4),blurRadius: 0)],
  borderRadius: BorderRadius.circular(6),
);

const kTransactionCardBoxText = TextStyle(
                              color: Colors.grey,
                              fontSize:14
                            );
const kDetailTransactionCardText = TextStyle(
                              color: Colors.grey,
                              fontSize:10
                            );
const kTransactionCardDoneeBoxText = TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:14,
                        ) ;
const kAdminTransactionCard = TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:24,
                            );
final kHomeDecoration= BoxDecoration(
  color: Color(0xfff8f8f8),
  boxShadow: [BoxShadow( color: Colors.grey.withOpacity(0.5),
        spreadRadius: 0,
        blurRadius: 5,
        offset: Offset(3, 3),)],
  borderRadius: BorderRadius.circular(9),
);

Radius kCurvedRadius = Radius.circular(6) ;
const kLeftBorderRadius = BorderRadius.only(topLeft:Radius.circular(6), bottomLeft: Radius.circular(6));
const kRightBorderRadius = BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6));
final  kTransactionDetail = BoxDecoration(
  color: Color(0xfff8f8f8),
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xAA1AAAEA),Color(0x5536AAE0)]
  ),
  boxShadow: [BoxShadow( color: Colors.grey.withOpacity(0.5),
        spreadRadius: 0,
        blurRadius: 5,
        offset: Offset(3, 3),)],
  borderRadius: BorderRadius.circular(9),
);
final kAmount = TextStyle(
                                        fontSize: 18,
                                        fontWeight:FontWeight.bold,
                                        color: Color(0xFFFA2E69),
                                      );