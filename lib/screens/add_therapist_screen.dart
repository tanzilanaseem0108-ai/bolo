// Nayi file: lib/screens/add_therapist_screen.dart
import 'package:flutter/material.dart';

class AddTherapistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Therapist"), backgroundColor: Colors.orange.shade800),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter Therapist Name or ID...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Dummy results
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text("Therapist Name ${index + 1}"),
                  subtitle: Text("Specialization: Autism Specialist"),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Front-end notification
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Request Sent!")));
                    },
                    child: Text("Connect"),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}