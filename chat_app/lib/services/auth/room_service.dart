// import 'package:chat_app/pages/room.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


//   /// The service responsible for managing rooms in the application.
//   class RoomService {
//     final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//     Future<Room?> createRoom(String roomName, String userId) async {
//       try {
//         DocumentReference roomRef = await _firestore.collection('rooms').add({
//           'name': roomName,
//           'CreatedBy': userId,
//           'CreatedAt': FieldValue.serverTimestamp(),
//         });

//         DocumentSnapshot roomSnapshot = await roomRef.get();
//         return Room.fromDocument(roomSnapshot);
//       } catch (e) {
//         print('Error handling room: $e');
//         return null;
//       }
//       }
//     }
