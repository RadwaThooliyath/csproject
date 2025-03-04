import 'package:csproject/constants/colors.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:flutter/material.dart';


class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.nyanza,
      appBar: AppBar(backgroundColor: AppColors.teal,
        title: AppText(data:"Contact Us",color: Colors.white,size: 16,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Have questions or feedback? We're here to help!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 16),
            _buildContactInfo(
              "Email: support@collegehub.com",
              Icons.email,
                  () => _launchEmail("support@collegehub.com"),
            ),
            _buildContactInfo(
              "Phone: +1 (123) 456-7890",
              Icons.phone,
                  () => _launchPhone("+11234567890"),
            ),
            _buildContactInfo(
              "Visit our office:",
              Icons.location_on,
                  () {
                // Add logic to open a map or provide office address
              },
            ),
            SizedBox(height: 16),
            _buildText(
              "We strive to respond to your inquiries as quickly as possible. Your satisfaction is our priority.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(String text, IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.blue,
            ),
            SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: TextStyle(fontSize: 16,color: Colors.white),
      ),
    );
  }

  void _launchEmail(String email) {
    // Add logic to launch the email app with the given email
  }

  void _launchPhone(String phoneNumber) {
    // Add logic to launch the phone app with the given phone number
  }
}


