class BookingDetails {
  String? featureimage;
  String? propertyname;
  String? price;

  BookingDetails({this.featureimage, this.propertyname, this.price});

  factory BookingDetails.fromJson(Map<String, dynamic> json) {
    return BookingDetails(
      featureimage: json['featureimage'],
      propertyname: json['propertyname'],
      price: json['price'],
    );
  }
}