import 'package:csproject/constants/colors.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:flutter/material.dart';


class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: AppColors.nyanza,
      appBar: AppBar( backgroundColor: AppColors.teal,
        title: AppText(data:"About Us",color: Colors.white,size: 16,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to CollegeHub",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
"CollegeHub serves as your all-in-one platform connecting students and departments, offering essential services like notifications, event updates, and more. Stay connected, informed, and engaged with ease!",             style: TextStyle(fontSize: 16,color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              "Key Features:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 8),
            _buildFeature("Never Miss a Notification"),
            _buildFeature("Easy Access"),
            _buildFeature("Events Registration"),
            _buildFeature("Secure and Reliable"),
            SizedBox(height: 16),
            Text(
              "Our Mission:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              "At CollegeHub, our mission is to provide a seamless online experience. We strive to connect Department with their students while ensuring a hassle-free and trustworthy process.",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(feature,style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}


