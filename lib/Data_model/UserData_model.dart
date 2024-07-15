class Booking {
  String? uid;
  String? bookingDate;
  String? bookingDateDigit;
  int? bookingHours;
  String? bookingId;
  String? bookingInitiatedDate;
  int? bookingPrice;
  int? bookingStatus;
  String? cancellationReason;
  String? checkinTime;
  String? couponCode;
  String? destinationId;
  String? featureImage;
  LatLng? latlng;
  int? payLaterPrice;
  int? paymentStatus;
  String? propertyAddress;
  String? propertyCity;
  String? propertyName;
  String? propertyPhone;
  String? propertyState;
  int? refundAmount;
  int? refundStatus;
  String? userEmail;
  String? userName;
  String? userPhone;

  Booking({
     this.uid,
     this.bookingDate,
     this.bookingDateDigit,
     this.bookingHours,
     this.bookingId,
     this.bookingInitiatedDate,
     this.bookingPrice,
     this.bookingStatus,
     this.cancellationReason,
     this.checkinTime,
     this.couponCode,
     this.destinationId,
     this.featureImage,
     this.latlng,
     this.payLaterPrice,
     this.paymentStatus,
     this.propertyAddress,
     this.propertyCity,
     this.propertyName,
     this.propertyPhone,
     this.propertyState,
     this.refundAmount,
     this.refundStatus,
     this.userEmail,
     this.userName,
     this.userPhone,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      uid: json['uid'],
      bookingDate: json['booking_date'],
      bookingDateDigit: json['booking_date_digit'],
      bookingHours: json['booking_hours'],
      bookingId: json['booking_id'],
      bookingInitiatedDate: json['booking_initiated_date'],
      bookingPrice: json['booking_price'],
      bookingStatus: json['booking_status'],
      cancellationReason: json['cancellation_reason'],
      checkinTime: json['checkin_time'],
      couponCode: json['coupon_code'],
      destinationId: json['destination_id'],
      featureImage: json['feature_image'],
      latlng: LatLng.fromJson(json['latlng']),
      payLaterPrice: json['pay_later_price'],
      paymentStatus: json['payment_status'],
      propertyAddress: json['property_address'],
      propertyCity: json['property_city'],
      propertyName: json['property_name'],
      propertyPhone: json['property_phone'],
      propertyState: json['property_state'],
      refundAmount: json['refund_amount'],
      refundStatus: json['refund_status'],
      userEmail: json['user_email'],
      userName: json['user_name'],
      userPhone: json['user_phone'],
    );
  }
}

class LatLng {
  double lat;
  double lng;

  LatLng({required this.lat, required this.lng});

  factory LatLng.fromJson(List<dynamic> json) {
    return LatLng(
      lat: json[0],
      lng: json[1],
    );
  }
}