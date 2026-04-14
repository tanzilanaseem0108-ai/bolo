import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Ye line Orientation lock karne ke liye zaruri hai

void main() {
  // App shuru hote hi ye batayega ke sirf Landscape mode chalega
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(BoloApp());
  });
}

class BoloApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BOLO',
      home: Scaffold(
        body: Center(
          child: Text(
            'BOLO App: Language Selection Screen Jald Ayegi!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}