class UserTransaction{
  final String transactionId;
  final  String donor;
  final  String donee;
  final  double amount;
  UserTransaction({
    this.transactionId,
    this.amount,
    this.donor,
    this.donee,
  });

  Map<String,dynamic>toMap(){
    return {
      'transactionId': transactionId,
      'amount': amount,
      'donor': donor,
      'donee': donee,
    };
  }

  UserTransaction.fromFirestore(Map <String,dynamic> firestore)
  : transactionId = firestore['transactionID'], 
    donor = firestore['donor'],
    donee = firestore['donee'],
    amount = firestore['amount'];
}