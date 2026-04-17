import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'parent_dashboard.dart';
import 'therapist_dashboard.dart';

// StatefulWidget zaroori hai taake controllers kaam kar saken
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1. Controllers ko define kiya (Red lines khatam karne ke liye)
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 2. loginUser function (Backend response ka front-end structure)
  Future<String?> loginUser(String email, String password) async {
    // Abhi ke liye hum "Parent" return kar rahe hain taake dashboard khul sakay
    // Jab backend ready hoga, yahan se actual role aayega
    await Future.delayed(Duration(seconds: 1)); // Loading effect
    if (email.isNotEmpty && password.isNotEmpty) {
      return "Parent"; // Test karne ke liye "Parent" ya "Therapist" likhein
    }
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isUrdu = Localizations.localeOf(context).languageCode == 'ur';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Text(
                  isUrdu ? "لاگ ان کریں" : "Login",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800
                  ),
                ),
                SizedBox(height: 30),

                // Email Field
                TextField(
                  controller: emailController, // Controller attach kiya
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.orange),
                    labelText: isUrdu ? "ای میل" : "Email",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 15),

                // Password Field
                TextField(
                  controller: passwordController, // Controller attach kiya
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.orange),
                    labelText: isUrdu ? "پاس ورڈ" : "Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 30),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade700
                    ),
                    onPressed: () async {
                      // Login Logic
                      String? userRole = await loginUser(
                          emailController.text,
                          passwordController.text
                      );

                      if (userRole == "Parent") {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => ParentDashboard()),
                              (route) => false,
                        );
                      } else if (userRole == "Therapist") {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => TherapistDashboard()),
                              (route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Invalid Login or Role not assigned")),
                        );
                      }
                    },
                    child: Text(
                        isUrdu ? "لاگ ان" : "Login",
                        style: TextStyle(color: Colors.white)
                    ),
                  ),
                ),

                // Link to Registration Screen
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistrationScreen())
                    );
                  },
                  child: Text(
                      isUrdu ? "نیا اکاؤنٹ بنائیں" : "Don't have an account? Register here"
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}