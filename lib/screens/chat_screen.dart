import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String therapistName;

  ChatScreen({required this.therapistName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.teal)),
            SizedBox(width: 10),
            Text(therapistName),
          ],
        ),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Column(
        children: [
          // Messages Area
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(15),
              children: [
                // Example Therapist Message
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text("Hello! How is Zain's progress today?"),
                  ),
                ),
                // Example Parent Message
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text("He is doing great, using the 3x5 grid easily."),
                  ),
                ),
              ],
            ),
          ),

          // Input Field Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.teal),
                  onPressed: () {
                    // Message send logic
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}