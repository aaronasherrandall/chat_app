import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String email;

  User({required this.id, required this.username, required this.email});

  // Define a factory constructor that creates a User from a Firestore document snapshot
  factory User.fromSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic> ?? {};

    // You need to make sure the fields exist and have the correct types in Firestore
    final String id = doc.id; // The document ID is used as the user's ID
    final String username = data['username'] as String? ?? 'No Name';
    final String email = data['email'] as String? ?? 'No Email';

    return User(
      id: id,
      username: username,
      email: email,
    );
  }
}
