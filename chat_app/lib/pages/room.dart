import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/services/auth/user.dart';

class Room {
  final String name;
  final String createdBy;
  final DateTime createdAt;
  final List<String> users; // Updated to List<String>

  Room({required this.name, required this.createdBy, required this.createdAt, required this.users});

  // Create a Room from a Firestore document
  factory Room.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic> ?? {};

    // Check for null and provide fallback values as necessary
    final String name = data['name'] as String? ?? 'Unknown Name';
    final String createdBy = data['createdBy'] as String? ?? 'Unknown Creator';
    final DateTime createdAt = (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
    final List<String> users = List<String>.from(data['users'] as List? ?? []); // Correctly handle the users array

    return Room(
      name: name,
      createdBy: createdBy,
      createdAt: createdAt,
      users: users,
    );
  }

// Convert a Room to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'users': users, // Include the users field
    };
  }

   Future<List<User>> getUsersDetails() async {
    List<User> userDetails = [];
    for (String userId in users) {
      // Fetch user details for userId
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      User user = User.fromSnapshot(userSnapshot); // Assuming you have a User class with this constructor
      userDetails.add(user);
    }
    return userDetails;
  }

  // In your Room class

Future<String> getCreatorName() async {
  try {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(createdBy).get();
    var data = userSnapshot.data();
    if (data != null) {
      // Cast the data to a Map<String, dynamic> before accessing its 'name' key
      Map<String, dynamic> userData = data as Map<String, dynamic>;
      String creatorName = userData['username'] as String? ?? 'No Name';
      print('Creator name retrieved: $creatorName'); // This should appear in your console.
      return creatorName;
    } else {
      print('User document does not exist or has no data.');
      return 'No Name';
    }
  } catch (e) {
    print('Error fetching creator name: $e');
    return 'No Name';
  }
}



  // static Room fromDocument(DocumentSnapshot<Object?> roomSnapshot) {}
}
