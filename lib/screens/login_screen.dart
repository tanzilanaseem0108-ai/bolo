import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'parent_dashboard.dart';
import 'therapist_dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // --- 1. Password toggle ke liye variable ---
  bool _isPasswordVisible = false;

  Future<String?> loginUser(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    if (email.isNotEmpty && password.isNotEmpty) {
      return "Parent";
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
            child: Form(
              key: _formKey,
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
                  TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.orange),
                      labelText: isUrdu ? "ای میل" : "Email",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return isUrdu ? "ای میل لکھنا ضروری ہے" : "Email is required";
                      }
                      if (!value.contains('@')) {
                        return isUrdu ? "ای میل میں @ ہونا ضروری ہے" : "Email must contain @";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  // --- 2. Password Field (With Toggle Logic) ---
                  TextFormField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible, // Toggle variable yahan use ho raha hai
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.orange),
                      labelText: isUrdu ? "پاس ورڈ" : "Password",
                      // --- Eye Icon Button ---
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.orange,
                        ),
                        onPressed: () {
                          // State update taake icon aur text hide/show ho
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return isUrdu ? "پاس ورڈ ضروری ہے" : "Password is required";
                      }
                      if (value.length < 6) {
                        return isUrdu ? "پاس ورڈ کم از کم 6 حروف کا ہو" : "Password must be at least 6 characters";
                      }
                      return null;
                    },
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
                        if (_formKey.currentState!.validate()) {
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
                        }
                      },
                      child: Text(
                          isUrdu ? "لاگ ان" : "Login",
                          style: TextStyle(color: Colors.white)
                      ),
                    ),
                  ),

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
      ),
    );
  }
}