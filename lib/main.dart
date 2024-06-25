import 'package:csproject/common/colors.dart';
import 'package:csproject/common/login_page.dart';
import 'package:csproject/common/splash_page.dart';
import 'package:csproject/firebase_options.dart';
import 'package:csproject/screens/HOD/homepage.dart';
import 'package:csproject/screens/Teacher/teacherhomepage.dart';
import 'package:csproject/screens/admin/admin_home_page.dart';
import 'package:csproject/screens/user/user_home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(






            textTheme: TextTheme(

              titleLarge: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontStyle: FontStyle.italic),
              titleMedium: TextStyle(color: Colors.white, fontSize: 20),
            ),

            scaffoldBackgroundColor:primaryColor,
            appBarTheme: AppBarTheme(
              backgroundColor: primaryColor,
                  iconTheme: IconThemeData(color: Colors.white)
            )
        ),
        home:Splashpage(),);
  }
}
