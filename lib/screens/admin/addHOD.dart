import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/common/validate.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/constants/data.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddHOD extends StatefulWidget {
  const AddHOD({super.key});

  @override
  State<AddHOD> createState() => _AddHODState();
}

class _AddHODState extends State<AddHOD> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();

  bool visible = false;

  final _addHOD = GlobalKey<FormState>();
  String? department;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: AppText(
          data: "Add HODs",
          color: Colors.white,
          size: 16,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        height: double.infinity,
        width: double.infinity,
        child: Form(
            key: _addHOD,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      SizedBox(
                        height: 20,
                      ),
                      InkResponse(
                        splashColor: Colors.orange.withOpacity(0.5),
                        onTap: () async {
                          if (_addHOD.currentState!.validate()) {
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
                                  'usertype': "hod",
                                  'createdat': DateTime.now(),
                                  "status": 1
                                }).then((value) {
                                  FirebaseFirestore.instance
                                      .collection('hod')
                                      .doc(user.user!.uid)
                                      .set({
                                    "uid": user.user!.uid,
                                    'usertype': "hod",
                                    'createdat': DateTime.now(),
                                    "status": 1,
                                    "phone": _phoneController.text,
                                    'email': _emailController.text,
                                    'name': _nameController.text,
                                    "imgurl": "",
                                    "department": department,
                                  }).then((value) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: AppText(
                                      data: "Added",
                                      color: AppColors.appBarColor,
                                    )));
                                    Navigator.pop(context);
                                  });
                                });
                              }
                            } catch (e) {
                              showsnackbar('failed');
                            }
                          }
                        },
                        child: Container(
                          height: 48,
                          width: 250,
                          decoration: BoxDecoration(
                              color: AppColors.appBarColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              child: Text(
                            "Add",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  void showsnackbar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
