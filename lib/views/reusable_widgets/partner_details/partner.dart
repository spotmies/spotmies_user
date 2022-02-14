class Partner {
  final String name;
  final String profilePictureUrl;
  final int phoneNumber;
  final String job;
  final int rate;
  final double rating;
  final int totalRatings;
  final String city;
  final List<PartnerCatalogue> partners;
  final List<PartnerReview> reviews;

  Partner(
      {required this.name,
      required this.profilePictureUrl,
      required this.phoneNumber,
      required this.job,
      required this.rate,
      required this.rating,
      required this.totalRatings,
      required this.city,
      required this.partners,
      required this.reviews});
  factory Partner.fromJson(Map<String, dynamic> json) {
    var partnerJson = json["partners"];
    var reviewJson = json["reviews"];
    List<PartnerCatalogue> partnerList = [];
    List<PartnerReview> reviewsList = [];
    for (var partner in partnerJson) {
      partnerList.add(PartnerCatalogue(partner["name"], partner["description"],
          int.parse(partner["rate"] as String), partner["profilePicture"]));
    }
    for (var review in reviewJson) {
      reviewsList.add(PartnerReview(
          name: review["name"],
          reviewDescription: review["description"],
          date: review["date"],
          profilePicture: review["profilePicture"],
          rating: int.parse(review["rating"] as String)));
    }
    return Partner(
        name: json["name"] as String,
        profilePictureUrl: json["profile_picture"] as String,
        phoneNumber: int.parse(json["phoneNumber"] as String),
        job: json["job"],
        rate: int.parse(json["rate"] as String),
        rating: double.parse(json["rating"] as String),
        totalRatings: int.parse(json["totalNumberOfOrders"] as String),
        city: json["city"],
        partners: partnerList,
        reviews: reviewsList);
  }
}

class PartnerCatalogue {
  final String name;
  final String description;
  final int rate;
  final String profilePicture;

  PartnerCatalogue(this.name, this.description, this.rate, this.profilePicture);
}

class PartnerReview {
  final String name;
  final String reviewDescription;
  final String date;
  final int rating;
  final String profilePicture;

  PartnerReview(
      {required this.name,
      required this.reviewDescription,
      required this.date,
      required this.rating,
      required this.profilePicture});
}
