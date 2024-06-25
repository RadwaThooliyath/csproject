import 'package:csproject/constants/colors.dart';
import 'package:flutter/material.dart';



class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: AppColors.nyanza,
      appBar: AppBar( backgroundColor: AppColors.teal,
        title: Text("Terms and Conditions",style: TextStyle(color: Colors.white,fontSize: 16),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "1. Acceptance of Terms",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 8),
            _buildText(
              "By using the CollegeHub app, you agree to comply with and be bound by these terms and conditions.",
            ),
            SizedBox(height: 16),
            Text(
              "2. Use of the App",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 8),
            _buildText(
              "You may use theCollegeHub app for lawful purposes only. You are prohibited from violating any applicable laws, rules, or regulations.",
            ),
            _buildText(
              "You are responsible for maintaining the confidentiality of your account and password and for restricting access to your device.",
            ),
            SizedBox(height: 16),
            // Add more sections as needed based on your terms and conditions
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 16,color: Colors.white),
      ),
    );
  }
}

