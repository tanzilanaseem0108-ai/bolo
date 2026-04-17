import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'parent_dashboard.dart';
import 'therapist_dashboard.dart';
import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Role select karne ke liye variable
  String selectedRole = 'Parent';

  @override
  Widget build(BuildContext context) {
    bool isUrdu = Localizations.localeOf(context).languageCode == 'ur';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(
              children: [
                Text(
                  isUrdu ? "اکاؤنٹ بنائیں" : "Create Account",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
                ),
                SizedBox(height: 20),

                // Name Field
                _buildTextField(isUrdu ? "نام" : "Full Name", Icons.person),
                SizedBox(height: 10),

                // Age Field
                _buildTextField(isUrdu ? "عمر" : "Age", Icons.cake, isNumber: true),
                SizedBox(height: 10),

                // Email Field
                _buildTextField(isUrdu ? "ای میل" : "Email", Icons.email),
                SizedBox(height: 10),

                // Password Field
                _buildTextField(isUrdu ? "پاس ورڈ" : "Password", Icons.lock, isPassword: true),
                SizedBox(height: 20),

                // ROLE SELECTION (Dropdown)
                Text(isUrdu ? "آپ کون ہیں؟" : "Select Your Role:"),
                DropdownButton<String>(
                  value: selectedRole,
                  items: <String>['Parent', 'Therapist'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value == 'Parent' ? (isUrdu ? "والدین" : "Parent") : (isUrdu ? "تھراپسٹ" : "Therapist")),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedRole = newValue!;
                    });
                  },
                ),

                SizedBox(height: 30),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                      // Registration Screen ke "Sign Up" button par
                      onPressed: () {
                        // Backend par data save karne ke baad:
                        if (selectedRole == "Parent") {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => ParentDashboard()),
                                (route) => false,
                          );
                        } else if (selectedRole == "Therapist") {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => TherapistDashboard()),
                                (route) => false,
                          );
                        }
                      },
                      child: Text(isUrdu ? "رجسٹریشن مکمل کریں" : "Sign Up", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),

                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),

                  child: Text(isUrdu ? "پہلے سے اکاؤنٹ ہے؟ لاگ ان" : "Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function taake code saaf rahay
  Widget _buildTextField(String label, IconData icon, {bool isPassword = false, bool isNumber = false}) {
    return TextField(
      obscureText: isPassword,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.orange),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}