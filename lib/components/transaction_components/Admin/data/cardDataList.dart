import 'package:flutter/material.dart';
import 'cardDataattribute.dart';

class DonationList {
  List <Donations> donationData = [
  Donations(
      day: 'Today' ,
      donorImage: 'download.jpg',
      donor: 'Chris Pratt',
      donee: 'Helping Hands',
      time: '30 minutes ago',
      amount: 950.0,
    ),
    Donations(
      day: 'Yesterday',
      donorImage: 'download.jpg',
      donor: 'Chadwick Boseman',
      donee: 'Kendriya Samaj',
      time: '1 day ago',
      amount: 1400.0,
    ),
    Donations(
      day: '5 days ago',
      donorImage: 'download.jpg',
      donor: 'Robert Downey Jr.',
      donee: 'Hamro Sewa Kendra',
      time: '30 Jun, 2020',
      amount: 10002000.0,
    ),
     
     ];

String getDonor(index){
  return donationData[index].donor;
}
String getDonorImage(index){
  return donationData[index].donorImage;
}
String getDonee(index){
  return donationData[index].donee;
}
String getTime(index){
  return donationData[index].time;
}
String getDay(index){
  return donationData[index].day;
}
double getAmount(index){
  return donationData[index].amount;
}
}
