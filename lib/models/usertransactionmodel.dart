class UserTransactionModel{
  final String transactionId;
  final  String donor;
  final  String donee;
  //final  double amount;
  UserTransactionModel({
    this.transactionId,
    //this.amount,
    this.donor,
    this.donee,
  });

  Map<String,dynamic>toMap(){
    return {
      'transactionId': transactionId,
      //'amount': amount,
      'donor': donor,
      'donee': donee,
    };
  }

  UserTransactionModel.fromFirestore(Map <String,dynamic> firestore)
  : transactionId = firestore['transactionId'], 
    donor = firestore['donor'],
    donee = firestore['donee'];
   // amount = firestore['amount'];
}