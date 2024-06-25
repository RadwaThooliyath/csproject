import 'package:csproject/constants/colors.dart';
import 'package:csproject/utils/appbutton.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      // Display a success message to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Password Reset"),
            content: Text("Password reset email sent. Check your inbox."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Display an error message to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to send password reset email. ${e.toString()}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(        backgroundColor: AppColors.nyanza,
      appBar: AppBar(
        backgroundColor: AppColors.teal,
        title: AppText(data: "Forgot Password",color: Colors.white,size: 16,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            AppText(data: "Enter your registred email id ",color: Colors.white,size: 18,),
           SizedBox(height: 20,),
            TextFormField(
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(

                  hintText: "Enter Email",
                  hintStyle: TextStyle(color: Colors.white54,fontSize: 14),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white54)
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Colors.white, width: 1))),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            AppButton(onTap:  _resetPassword, child: AppText(data: "Reset Password",color: Colors.white,),height: 52,color: AppColors.rustyred,)


          ],
        ),
      ),
    );
  }
}


