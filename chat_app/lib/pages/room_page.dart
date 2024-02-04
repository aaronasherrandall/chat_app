
import 'package:chat_app/pages/room.dart';
import 'package:chat_app/services/auth/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoomPage extends StatelessWidget {
  final Room room;

  const RoomPage({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // access the firebase instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(room.name), // Updated to use Room object
      ),
      body: Column(
        children: [
          FutureBuilder<String>(
            future: room.getCreatorName(), // Fetch the creator's name
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading creator name...');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // Display the creator's name if we have it
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Welcome to ${room.name}, created by ${snapshot.data} on ${room.createdAt.toString()}'),
                );
              } else {
                return Text('Creator name not available');
              }
            },
          ),
          Expanded(
            child: _buildUserList(room), // Call the separate function here
          ),
        ],
      ),
    );
  }
}
  // Define the function that returns a FutureBuilder widget
  Widget _buildUserList(Room room) {
    return FutureBuilder<List<User>>(
      future: room.getUsersDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<User> users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(users[index].name),
                // Add more user details here as needed
              );
            },
          );
        } else {
          return Text('No users found');
        }
      },
    );
  }
