import 'package:flutter/material.dart';
import '../Admin/transaction_card.dart';
import './data/cardDataList.dart';
import './data/cardDataattribute.dart';
class TransactionCardCreator {
  Column donationData(){
    String day;
    String donor;
    String donorImage;
    String time;
    String donee;
    double amount;
    List <TransactionCard> donationLists = [];
    DonationList recentDonations = DonationList();
    int index = 0;
    for(Donations data in recentDonations.donationData){
      day = recentDonations.getDay(index);
      donor = recentDonations.getDonor(index);
      time = recentDonations.getTime(index);
      donee = recentDonations.getDonee(index);
      amount = recentDonations.getAmount(index);
      donorImage = recentDonations.getDonorImage(index);
      donationLists.add(
        TransactionCard(day: day, donor: donor, donorImage: donorImage, time: time, donee: donee,amount: amount,)
      );
      index++;
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: donationLists,
  );
  }
  
}