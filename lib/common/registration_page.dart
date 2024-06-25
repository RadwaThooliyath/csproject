import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/common/login_page.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/constants/data.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:csproject/common/validate.dart';

class UserRegistrationPage extends StatefulWidget {
  var dept;
  UserRegistrationPage({super.key, this.dept});

  @override
  State<UserRegistrationPage> createState() => _UserRegistrationPageState();
}

class _UserRegistrationPageState extends State<UserRegistrationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  bool visible = false;
  String? department;
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.teal,
        title: AppText(
          data: "Add Student",
          color: Colors.white,
          size: 16,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(),
        child: Form(
            key: _loginKey,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        data: "Signup with Email",
                        size: 18,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name is mandatory";
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        controller: _nameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            hintText: "Enter Name",
                            hintStyle:
                                TextStyle(color: Colors.white54, fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          return validate.phnvalidator(value!);
                        },
                        controller: _phoneController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.smartphone,
                              color: Colors.white,
                            ),
                            hintText: "Enter Phone",
                            hintStyle:
                                TextStyle(color: Colors.white54, fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return validate.emailValidator(value!);
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                            hintText: "Enter email",
                            hintStyle:
                                TextStyle(color: Colors.white54, fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is manadatory";
                          } else if (value.length < 8) {
                            return "Password should be min of 8 characters";
                          }
                        },
                        obscureText: visible,
                        controller: _passswordController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    visible = !visible;
                                  });
                                },
                                icon: visible == false
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.white,
                                      )
                                    : Icon(Icons.visibility_off)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            hintText: "Enter Password",
                            hintStyle:
                                TextStyle(color: Colors.white54, fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        icon: Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            hintStyle:
                                TextStyle(color: Colors.white54, fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1))),
                        style: TextStyle(color: Colors.black),
                        hint: Text(
                          "Select department",
                          style: TextStyle(color: Colors.white54),
                        ),
                        isExpanded: true,
                        value: department,
                        onChanged: (value) {
                          setState(() {
                            department = value;
                          });
                        },
                        items: departments.map((dept) {
                          return DropdownMenuItem<String>(
                            value: dept,
                            child: Text(dept.toString()),
                          );
                        }).toList(),
                      ),
                      //DropdownButtonFormField<String>(
                      //
                      //   icon: Icon(Icons.arrow_downward,color: Colors.white,),
                      //
                      //   decoration: InputDecoration(
                      //       hintStyle: TextStyle(color: Colors.white54,fontSize: 14),
                      //
                      //       enabledBorder: OutlineInputBorder(
                      //
                      //           borderRadius: BorderRadius.circular(10),
                      //           borderSide: BorderSide(color: Colors.white, width: 1)
                      //       ),
                      //       errorBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(color: Colors.red)),
                      //       focusedBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //           borderSide:
                      //           BorderSide(color: Colors.white, width: 1))
                      //   ),
                      //   style: TextStyle(color: Colors.black),
                      //
                      //   hint: Text("Select department",style: TextStyle(color: Colors.white54),),
                      //
                      //   isExpanded: true,
                      //   value: department,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       department = value;
                      //     });
                      //   },
                      //   items: departments.map((dept) {
                      //     return DropdownMenuItem<String>(
                      //       value: dept,
                      //       child: Text(dept.toString()),
                      //     );
                      //   }).toList(),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      InkResponse(
                        splashColor: Colors.orange.withOpacity(0.5),
                        onTap: () async {
                          if (_loginKey.currentState!.validate()) {
                            try {
                              UserCredential user = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passswordController.text);

                              if (user != null) {
                                FirebaseFirestore.instance
                                    .collection('login')
                                    .doc(user.user!.uid)
                                    .set({
                                  "uid": user.user!.uid,
                                  'usertype': "user",
                                  'createdat': DateTime.now(),
                                  "status": 1
                                }).then((value) {
                                  FirebaseFirestore.instance
                                      .collection('student')
                                      .doc(user.user!.uid)
                                      .set({
                                    "uid": user.user!.uid,
                                    'usertype': "user",
                                    'createdat': DateTime.now(),
                                    "status": 1,
                                    "phone": _phoneController.text,
                                    'email': _emailController.text,
                                    'name': _nameController.text,
                                    "imgurl": "assets/img/logo.jpg",
                                    "department": widget.dept,
                                    "semester": "1",
                                  }).then((value) {
                                    Navigator.pop(context);
                                  });
                                });
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: Container(
                          height: 48,
                          width: 250,
                          decoration: BoxDecoration(
                              color: AppColors.rustyred,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              child: AppText(
                            data: "Register",
                            size: 18,
                            color: Colors.white,
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     AppText(data: "Already have an Account",color: Colors.white,),
                      //     TextButton(
                      //       onPressed: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => (Loginpage())));
                      //       },
                      //       child:   AppText(data: "Login",color: Colors.white,),)
                      //   ],
                      // )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
