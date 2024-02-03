import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final String name;
  final String createdBy;
  final DateTime createdAt;

  Room({required this.name, required this.createdBy, required this.createdAt});

  // Create a Room from a Firestore document
  factory Room.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic> ?? {};

    // Check for null and provide fallback values as necessary
    final String name = data['name'] as String? ?? 'Unknown Name';
    final String createdBy = data['createdBy'] as String? ?? 'Unknown Creator';
    final DateTime createdAt = (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();

    return Room(
      name: name,
      createdBy: createdBy,
      createdAt: createdAt,
    );
  }

// Convert a Room to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'createdBy': createdBy,
      'createdAt': createdAt,
    };
  }

  // static Room fromDocument(DocumentSnapshot<Object?> roomSnapshot) {}
}
