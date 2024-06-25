import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/common/colors.dart';
import 'package:csproject/common/registration_page.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/screens/HOD/homepage.dart';
import 'package:csproject/screens/Teacher/teacherhomepage.dart';
import 'package:csproject/screens/admin/admin_home_page.dart';
import 'package:csproject/screens/user/user_home_page.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:csproject/common/validate.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool visible = false;

  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.scaffoldColor
          ),
          child: Form(key: _loginKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(data:"Login with email",
                  color: Colors.white,size: 18,fw: FontWeight.bold,),
                SizedBox(
                  height: 20,
                ),


                TextFormField(
                  validator: (value) {
                    return validate.emailValidator(value!);
                  },
                  style: TextStyle(color: Colors.white),
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email,color: Colors.white,),
                    hintText: "Enter email",
                    hintStyle: TextStyle(color: Colors.white54,fontSize: 14),

                    enabledBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white, width: 1)
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        BorderSide(color: Colors.white, width: 1)),


                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is mandatory";
                    } else if (value.length < 8) {
                      return "Password should be min of 8 characters";
                    }
                  },
                  obscureText: visible,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                        icon: visible == false
                            ? Icon(Icons.visibility,color: Colors.white,)
                            : Icon(Icons.visibility_off)),
                    prefixIcon: Icon(Icons.lock,color: Colors.white,),
                    hintText: "Enter Password",
                    hintStyle: TextStyle(color: Colors.white54,fontSize: 14),

                    enabledBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white, width: 1)
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        BorderSide(color: Colors.white, width: 1)),),
                ),
                SizedBox(
                  height: 20,
                ),
                InkResponse(
                  splashColor: Colors.orange.withOpacity(0.5),
                  onTap: ()async {
                    if (_loginKey.currentState!.validate()) {

                      if(_emailController.text=="admin@gmail.com" && _passwordController.text=="12345678"){

                        SharedPreferences _pref= await SharedPreferences.getInstance();
                        _pref.setString('token',"admintoken123" );
                        _pref.setString('name',"admin");
                        _pref.setString('type',"admin");
                        _pref.setString('email',"admin@gmail.com");
                        _pref.setString('phone',"9847543117");

                        _pref.setString('img',"assets/img/jamia.jpeg");
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AdminHomePage()), (route) => false);

                      }else{

                        DocumentSnapshot? userData;

                        try{
                          UserCredential user=await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);

                          if(user!=null){


                            userData= await FirebaseFirestore.instance.collection('login').doc(user.user!.uid).get();

                            if(userData!['usertype']=="user"){


                              print("am hereeeeeeeeeeeeeee");



                              DocumentSnapshot userData= await FirebaseFirestore.instance.collection('student').doc(user.user!.uid).get();

                              print(userData['name']);
                              print(userData['usertype']);
                              print(userData['email']);
                              print(userData['phone']);

                              print(userData['imgurl']);
                              print(userData['semester']);
                              print(userData['department']);


                              SharedPreferences _pref= await SharedPreferences.getInstance();
                              _pref.setString('token',user.user!.getIdToken().toString() );
                              _pref.setString('name',userData['name']);
                              _pref.setString('type',userData['usertype']);
                              _pref.setString('email',userData['email']);
                              _pref.setString('phone',userData['phone']);

                              _pref.setString('img',userData['imgurl']??"assets/img/profile.png");
                              _pref.setString('sem',userData['semester']??"1");
                              _pref.setString('dept',userData['department']??"CS");
                              _pref.setString('id', user.user!.uid);


                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>UserHomePage()), (route) => false);
                            }

                            else if(userData!['usertype']=="hod"){


                              print("am hereeeeeeeeeeeeeee");



                              DocumentSnapshot userData= await FirebaseFirestore.instance.collection('hod').doc(user.user!.uid).get();


                              SharedPreferences _pref= await SharedPreferences.getInstance();
                              _pref.setString('token',user.user!.getIdToken().toString() );
                              _pref.setString('name',userData['name']);
                              _pref.setString('type',userData['usertype']);
                              _pref.setString('email',userData['email']);
                              _pref.setString('phone',userData['phone']);

                              _pref.setString('img',userData['imgurl']);

                              _pref.setString('dept',userData['department']);
                              _pref.setString('id', userData['uid']);


                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HODHome(data:userData ,)), (route) => false);
                            }
                            else if(userData!['usertype']=="teacher"){


                              print("am hereeeeeeeeeeeeeee");



                              DocumentSnapshot userData= await FirebaseFirestore.instance.collection('teacher').doc(user.user!.uid).get();


                              SharedPreferences _pref= await SharedPreferences.getInstance();
                              _pref.setString('token',user.user!.getIdToken().toString() );
                              _pref.setString('name',userData['name']);
                              _pref.setString('type',userData['usertype']);
                              _pref.setString('email',userData['email']);
                              _pref.setString('phone',userData['phone']);

                              _pref.setString('img',userData['imgurl']);

                              _pref.setString('dept',userData['department']);
                              _pref.setString('id', userData['uid']);


                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TeacherHome(data:userData ,)), (route) => false);
                            }


                          }



                        }
                        catch(e){
                          print(e);
                        }

                      }




                    }
                  },
                  child: Container(
                    height: 48,
                    width: 250,
                    decoration: BoxDecoration(
                        color: AppColors.appBarColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(child: AppText(data: "Login",color: Colors.white,size: 18,)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     AppText(data: "New here?",color: Colors.white,),
                //     TextButton(
                //       onPressed: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => (UserRegistrationPage())));
                //       },
                //       child:   AppText(data: "Signup Now",color: Colors.white,),)
                //   ],
                // )
              ],
            ),
          ),
        )
    );
  }
}

