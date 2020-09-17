import 'package:flutter/material.dart';

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