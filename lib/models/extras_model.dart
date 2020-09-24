class DonorDetail {
  final String id;
  final double donatedAmount;
  final int countDonation;

  DonorDetail({this.id, this.donatedAmount, this.countDonation});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'donated_amount': donatedAmount,
      'count_donation': countDonation
    };
  }

  DonorDetail.fromFirestore(Map<String, dynamic> firestore)
      : id = firestore['id'],
        donatedAmount = double.parse(firestore['donated_amount'].toString()),
        countDonation = firestore['count_donation'];
}

class OrganizationDetail {
  final String id;
  final String description;
  final String bannerImage;
  final double receivedAmount;
  final int countDonation;

  OrganizationDetail(
      {this.id,
      this.description,
      this.bannerImage,
      this.receivedAmount,
      this.countDonation});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'banner_image': bannerImage,
      'received_amount': receivedAmount,
      'count_donation': countDonation
    };
  }

  OrganizationDetail.fromFirestore(Map<String, dynamic> firestore)
      : id = firestore['id'],
        description = firestore['description'],
        bannerImage = firestore['banner_image'],
        receivedAmount = double.parse(firestore['received_amount'].toString()),
        countDonation = firestore['count_donation'];
}

class AdminDetail{
  final double donationAmount;
  final int countDonation;
  final int countDonor;
  final int countOrganization;
  final int pendingVerfCount;

  AdminDetail({
    this.donationAmount,
    this.countDonation,
    this.countDonor,
    this.countOrganization,
    this.pendingVerfCount
  });

  Map<String,dynamic> toMap(){
    return {
      'donation_amount': donationAmount,
      'count_donation': countDonation,
      'count_donor': countDonor,
      'count_organization': countOrganization,
      'count_pendingVerification': pendingVerfCount,
    };
  }

  AdminDetail.fromFirestore(Map<String,dynamic> firestore)
  :donationAmount = firestore['donation_amount'],
  countDonation = firestore['count_donation'],
  countDonor = firestore['count_donor'],
  countOrganization = firestore['count_organization'],
  pendingVerfCount = firestore['count_pendingVerification'];
}