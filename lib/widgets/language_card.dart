import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  final String label;
  final String flagEmoji;
  final VoidCallback onTap;

  LanguageCard({required this.label, required this.flagEmoji, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        height: 140,
        decoration: BoxDecoration(
          color: Color(0xFFFFE0B2), // Light Orange [cite: 48]
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.orange, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(flagEmoji, style: TextStyle(fontSize: 50)),
            SizedBox(height: 10),
            Text(label, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}