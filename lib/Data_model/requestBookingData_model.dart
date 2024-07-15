import 'package:cloud_firestore/cloud_firestore.dart';

class RequestBookingData {
  List<String>? amenities;

  List<String>? areas;

  String? city;
  String? description;
  List<String>? destination_policy;
  GeoPoint? latlng;
  String? manager_phoneno;
  String? pincode;
  String? property_address;
  String? state;

  RequestBookingData({
    this.amenities,
    this.areas,
    this.city,
    this.description,
    this.destination_policy,
    this.latlng,
    this.manager_phoneno,
    this.pincode,
    this.property_address,
    this.state,
  });

  factory RequestBookingData.fromMap(Map<String, dynamic> map) {
    return RequestBookingData(
      amenities:
          map['amenities'] != null ? List<String>.from(map['amenities']) : [],
      areas: map['areas'] != null ? List<String>.from(map['areas']) : [],
      city: map['city'],
      description: map['description'],
      destination_policy: map['destination_policy'] != null
          ? List<String>.from(map['destination_policy'])
          : [],
      latlng: map['latlng'],
      manager_phoneno: map['manager_phoneno'],
      pincode: map['pincode'],
      property_address: map['property_address'],
      state: map['state'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amenities': amenities,
      'areas': areas,
      'city': city,
      'description': description,
      'destination_policy': destination_policy,
      'latlng': latlng,
      'manager_phoneno': manager_phoneno,
      'pincode': pincode,
      'property_address': property_address,
      'state': state,
    };
  }
}

Future<RequestBookingData> getDestionationDetails({required String id}) async {
  var data = await FirebaseFirestore.instance
      .collection("destination")
      .doc(id)
      .collection('details')
      .doc('description')
      .get();
  print("data=${data}");
  return RequestBookingData.fromMap(data.data() ?? {});
}
