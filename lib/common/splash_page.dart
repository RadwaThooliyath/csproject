import 'package:csproject/common/login_page.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/screens/HOD/homepage.dart';
import 'package:csproject/screens/Teacher/teacherhomepage.dart';
import 'package:csproject/screens/admin/admin_home_page.dart';
import 'package:csproject/screens/user/user_home_page.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {



  String? _type;
  String?uid;
  String?name;
  String?email;
  String?phone;

  Map<String,dynamic>data={};


  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _type = await _pref.getString('type');
    email= await _pref.getString('email');
    name = await _pref.getString('name');
    phone = await _pref.getString('phone');
    uid = await _pref.getString('uid');

    setState(() {

      data={

        'uid':uid,
        'name':name,
        'email':email,
        'type':_type,
        'phone':phone
      };
    });
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences _pref=await SharedPreferences.getInstance();
    final token= _pref.getString('token');
print("************************************");
print(token);
print("************************************");


    if (token==null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Loginpage()));
    } else {
      if (_type == "admin" ) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminHomePage()),
                (route) => false);
      }else if(_type=="user" ){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => UserHomePage()),
                (route) => false);
      }
      else if(_type=="hod" ){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HODHome()),
                (route) => false);
      }

      else if(_type=="teacher" ){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => TeacherHome()),
                (route) => false);
      }

      else{
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => ErrorPage(errorMessage: "Contact Administrator")),
        //         (route) => false);
      }

    }
  }
  @override
  void initState() {
    getData();
    // Future.delayed(
    //   Duration(seconds: 3),
    //     ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()))
    // );
    var d = Duration(seconds:5);
    Future.delayed(d, () {
      _checkLoginStatus();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,

      body:Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),
                child: Image.asset('assets/img/clg.png')),
            SizedBox(height: 10,),
            AppText(data: "CollegeHub",color: Colors.white60,fw: FontWeight.bold,size: 22,)

          ],
        ),
      ),
    );
  }
}