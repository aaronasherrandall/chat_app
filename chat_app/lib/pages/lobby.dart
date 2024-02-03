import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/pages/room.dart';
import 'package:chat_app/pages/room_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Lobby extends StatefulWidget {
  const Lobby({Key? key}) : super(key: key);

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  // text controllers
  final createRoomController = TextEditingController();
  /// List of room names.
  final _roomName = <Room>[];




  // sign user out
  void signOut() {
    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[700], // Set the app bar color to blue
        title: const Text('Lobby'),
        actions: [
          // sign out button
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
        // Set the default text color to white
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // logo
                Icon(
                  Icons.people,
                  size: 100,
                  color: Colors.grey[800],
                ),
                // Expanded widget to allow ListView to take remaining space
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('rooms').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Loading');
                    }

                    // Build the list of room tiles
                    return Expanded(
                      child: ListView(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          // Use Room.fromDocument to ensure consistency in how Room objects are created
                          Room selectedRoom = Room.fromDocument(document);
                          return ListTile(
                            title: Text(selectedRoom.name),
                            onTap: () {
                              // Handle room selection
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => RoomPage(room: selectedRoom)),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 25),

                MyTextField(
                  controller: createRoomController,
                  hintText: 'Room Name',
                  obscureText: false,
                  ),

                const SizedBox(height: 25),
                /// Creates a room with the given room name.
                ///
                /// The [onTap] callback is triggered when the button is tapped.
                /// The [text] parameter specifies the text to be displayed on the button.
                MyButton(
                  onTap: () async  { // Mark this callback as async
                    if (createRoomController.text.isNotEmpty) {
                      await createRoom(createRoomController.text);
                      createRoomController.clear(); // Clear the input field after creating the room
                    }
                  },
                  text: 'Create Room',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoomList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        // room name -> divider -> room name -> divider
        // let's return a divider on every odd occurrence
        if (item.isOdd) return Divider();

        // calculate # of word pairs in list view - divider widget
        final index = item ~/ 2;

        // generate new room
        if (index >= _roomName.length) {
          _roomName.add(Room(name: 'Room Name', createdBy: 'User ID', createdAt: DateTime.now()));
        }

        // return list tile for each iteration
        return _buildRow(_roomName[index]);
      },
    );
  }

  Widget _buildRow(Room room) {
    return ListTile(
      // TODO
      //title: Text(room.name), // Replace 'name' with the actual property name from Firebase/Firestore
      onTap: () {
        // Handle room selection
      },
    );
  }

  Future<void> createRoom(String roomName) async {
  try {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    String? userId = await authService.getCurrentUserId();

    // Default to "Unknown User" if userId is null. Adjust as needed.
    String createdBy = userId ?? "Unknown Creator";

    // Logic to create room and add it to Firebase/Firestore
    // Perform the async operation
    DocumentReference roomRef = await FirebaseFirestore.instance.collection('rooms').add({
      'name': roomName,
      'created': userId,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Fetch the newly created document to get the server-resolved timestamp
    DocumentSnapshot roomSnapshot = await roomRef.get();
    // Create the Room object with data from Firestore
    Room room = Room.fromDocument(roomSnapshot);

    // Check if the widget is still mounted before navigating
    if (!mounted) return; // This check ensures we don't use the context if the widget's state is disposed
    // Navigate to RoomPage
    // Proceed with navigation if the widget is still mounted
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => RoomPage(room: room)),
      );
  } catch (e) {
    print("Error creating room: $e");
    // Optionally show an error message to the user
    if (!mounted) return;
    // Show error message or handle the error within the UI context if needed
    // Optionally show an error message to the user
  }
}
}

// move this to its own file eventually
// need to define it
// class RoomName {}
