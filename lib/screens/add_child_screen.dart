import 'package:flutter/material.dart';

class AddChildScreen extends StatefulWidget {
  @override
  _AddChildScreenState createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for front-end data collection
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedVoice = "Male"; // Default voice

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Child Profile"),
        backgroundColor: Colors.orange.shade800,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Child Name
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Child Name", icon: Icon(Icons.person)),
              ),
              SizedBox(height: 15),

              // Age
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Age", icon: Icon(Icons.cake)),
              ),
              SizedBox(height: 15),

              // Email (For Child Login)
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Child Email (for login)", icon: Icon(Icons.email)),
              ),
              SizedBox(height: 15),

              // Password
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Set Password", icon: Icon(Icons.lock)),
              ),
              SizedBox(height: 25),

              // Voice Selection (Toggle)
              Text("Select App Voice:", style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: Text("Male / Man"),
                    selected: selectedVoice == "Male",
                    onSelected: (bool selected) {
                      setState(() { selectedVoice = "Male"; });
                    },
                  ),
                  SizedBox(width: 10),
                  ChoiceChip(
                    label: Text("Female / Woman"),
                    selected: selectedVoice == "Female",
                    onSelected: (bool selected) {
                      setState(() { selectedVoice = "Female"; });
                    },
                  ),
                ],
              ),
              SizedBox(height: 40),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade700),
                  onPressed: () {
                    // Front-end validation
                    if (_formKey.currentState!.validate()) {
                      // Yahan backend API ko data bheja jayega
                      print("Saving Child: ${nameController.text}");
                      Navigator.pop(context); // Wapis Dashboard par
                    }
                  },
                  child: Text("CREATE PROFILE", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}