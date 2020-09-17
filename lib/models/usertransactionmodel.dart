class UserTransactionModel{
  final String time;
  final String donorId;
  final String transactionId;
  final  String donor;
  final String donorImage;
  final  String donee;
  final  String amount;
  UserTransactionModel({
    this.transactionId,
    this.time,
    this.amount,
    this.donor,
    this.donorImage,
    this.donee,
    this.donorId
  });

  Map<String,dynamic>toMap(){
    return {
      'transactionId': transactionId,
      'donorImage': donorImage,
      'amount': amount,
      'donor': donor,
      'donee': donee,
      'time': time,
      'donorId' : donorId,
    };
  }

  UserTransactionModel.fromFirestore(Map <String,dynamic> firestore)
  : transactionId = firestore['transactionId'],
    donorImage = firestore['donorImage'], 
    donor = firestore['donor'],
    donee = firestore['donee'],
   amount = firestore['amount'],
   time = firestore['time'],
   donorId = firestore['donorId'];
}