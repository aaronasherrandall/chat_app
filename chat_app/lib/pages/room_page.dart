
import 'package:chat_app/pages/room.dart';
import 'package:flutter/material.dart';

class RoomPage extends StatelessWidget {
  final Room room;

  const RoomPage({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(room.name), // Updated to use Room object
      ),
      body: Center(
        child: Text('Welcome to ${room.name}, created by ${room.createdBy} on ${room.createdAt}'),
      ),
    );
  }
}
