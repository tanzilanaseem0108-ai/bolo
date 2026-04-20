import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'parent_dashboard.dart';
import 'therapist_dashboard.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String selectedRole = 'Parent';

  // 1. Form Key aur Controllers (Backend ke liye)
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 2. Password visibility toggle variable
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
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
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            // 3. Form widget wrap kiya
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    isUrdu ? "اکاؤنٹ بنائیں" : "Create Account",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
                  ),
                  SizedBox(height: 10),

                  // Name Field
                  _buildTextField(
                    isUrdu ? "نام" : "Full Name",
                    Icons.person,
                    controller: nameController,
                    nextAction: TextInputAction.next,
                  ),
                  SizedBox(height: 10),

                  // Age Field
                  _buildTextField(
                    isUrdu ? "عمر" : "Age",
                    Icons.cake,
                    isNumber: true,
                    controller: ageController,
                    nextAction: TextInputAction.next,
                  ),
                  SizedBox(height: 10),

                  // Email Field
                  _buildTextField(
                    isUrdu ? "ای میل" : "Email",
                    Icons.email,
                    controller: emailController,
                    nextAction: TextInputAction.next,
                    isEmail: true,
                  ),
                  SizedBox(height: 10),

                  // Password Field
                  _buildTextField(
                    isUrdu ? "پاس ورڈ" : "Password",
                    Icons.lock,
                    isPassword: true,
                    controller: passwordController,
                    nextAction: TextInputAction.done,
                  ),
                  SizedBox(height: 20),

                  // ROLE SELECTION
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
                      onPressed: () {
                        // 4. Validation check before navigation
                        if (_formKey.currentState!.validate()) {
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
      ),
    );
  }

  // Helper function updated for Validation, Auto-Next and Password Toggle
  Widget _buildTextField(String label, IconData icon, {
    bool isPassword = false,
    bool isNumber = false,
    bool isEmail = false,
    required TextEditingController controller,
    required TextInputAction nextAction,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? !_isPasswordVisible : false,
      keyboardType: isNumber ? TextInputType.number : (isEmail ? TextInputType.emailAddress : TextInputType.text),
      textInputAction: nextAction,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.orange),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        // Password toggle icon logic
        suffixIcon: isPassword ? IconButton(
          icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.orange),
          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
        ) : null,
      ),
      // --- All Validation Requirements ---
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Required field";
        }
        if (isEmail && !value.contains('@')) {
          return "Invalid email (@ missing)";
        }
        if (isPassword && value.length < 6) {
          return "Min 6 characters required";
        }
        if (isNumber && int.tryParse(value) == null) {
          return "Numbers only";
        }
        return null;
      },
    );
  }
}