import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  String name;
  String email;
  String phone;

  UserProfile({required this.name, required this.email, required this.phone});

  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProfile(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
    );
  }
}