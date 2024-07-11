import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeDestinationData {
   var id;
   String? city;
   String? featureimage;
   String? manageremail;
   String? managername;
   String? managerphoneno;
   String? propertyAddress;
   String? propertyname;
   String? state;
   String? latlng;
   String? status;
   int? type;
   List<String>? propertyImages;
   List<String>? hourlist;
   List<String>? paymentmethod;
   List<String>? numberOfHours;
   List<String>? pricelist;
   double? price;

   HomeDestinationData({
      this.id,
      this.city,
      this.featureimage,
      this.manageremail,
      this.managername,
      this.managerphoneno,
      this.propertyAddress,
      this.propertyname,
      this.state,
      this.latlng,
      this.status,
      this.type,
      this.propertyImages,
      this.hourlist,
      this.paymentmethod,
      this.numberOfHours,
      this.pricelist,
      this.price,
   });

   factory HomeDestinationData.fromMap(Map<String, dynamic> map) {
      return HomeDestinationData(
         id: map['id'],
         city: map['city'],
         featureimage: map['feature_image'],
         manageremail: map['manager_email'],
         managername: map['manager_name'],
         managerphoneno: map['manager_phone_no'],
         propertyAddress: map['property_address'],
         propertyname: map['property_name'],
         state: map['state'],
         latlng : map['latlng'].toString(),
         status: map['status'],
         type:map['type'],
         propertyImages: map['property_images'] != null ? List<String>.from(map['property_images']) : [],
         hourlist: map['hour_list'] != null? List<String>.from(map['hour_list']) : [],
         paymentmethod: map['payment_method'] != null ? List<String>.from(map['payment_method']) : [],
         pricelist: map['price_list']!= null ? List<String>.from(map['price_list'].map((x)=> x.toString())) : [],
         price: double.tryParse(map['price'].toString()),
      );
   }
   Map<String, dynamic> toMap() {
      return {
         'id': id,
         'city': city,
         'feature_image': featureimage,
         'manager_email': manageremail,
         'manager_name': managername,
         'manager_phone_no': managerphoneno,
         'property_address': propertyAddress,
         'property_name':propertyname,
         'state':state,
         'latlng':latlng,
         'status':status,
         'type':type,
         'property_images': propertyImages,
         'hour_list':hourlist,
         'payment_method':paymentmethod,
         'price_list':pricelist,
         'price': price,
      };
   }
}

Future<List<HomeDestinationData>> getOffersStream()async {

   var data  =  await FirebaseFirestore.instance.collection("destination").get();
   print("data=${data}");
   return data.docs.map((element)=>HomeDestinationData.fromMap(element.data())).toList();
}