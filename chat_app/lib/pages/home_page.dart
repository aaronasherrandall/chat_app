import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Lobby extends StatefulWidget {
  const Lobby({Key? key}) : super(key: key);

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  // text controllers
  final createRoomController = TextEditingController();
  /// List of room names.
  final _roomName = <RoomName>[];

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
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      Container(
                        height: 50,
                        color: Colors.amber[600],
                        child: const Center(child: Text('Entry A')),
                      ),
                      Container(
                        height: 50,
                        color: Colors.amber[500],
                        child: const Center(child: Text('Entry B')),
                      ),
                      Container(
                        height: 50,
                        color: Colors.amber[100],
                        child: const Center(child: Text('Entry C')),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                MyTextField(
                  controller: createRoomController,
                  hintText: 'Room Name',
                  obscureText: false,
                  ),

                const SizedBox(height: 25),
                MyButton(
                  onTap: createRoom,
                  text: 'Create Room'),
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
          _roomName.add(RoomName());
        }

        // return list tile for each iteration
        return _buildRow(_roomName[index]);
      },
    );
  }

  Widget _buildRow(RoomName room) {
    return ListTile(
      // TODO
      //title: Text(room.name), // Replace 'name' with the actual property name from Firebase/Firestore
      onTap: () {
        // Handle room selection
      },
    );
  }

  void createRoom() {
    // logic to create room and add it to Firebase/Firestore
    // Once the room is created, add it to the _roomName list
    final newRoom = RoomName(); // Replace 'RoomName' with the actual room model class
    _roomName.add(newRoom);
  }

}

// move this to its own file eventually
// need to define it
class RoomName {}
