import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/screens/user/edit_profile.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';





class ProfilePage extends StatefulWidget {
  final  data;
  const ProfilePage({super.key,this.data});


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String? _type;

  String?uid;

  String?name;

  String?email;

  String?phone;
  String?address;
  String?location;
  String?img;

  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _type = await _pref.getString('type');
    email= await _pref.getString('email');
    name = await _pref.getString('name');
    phone = await _pref.getString('phone');
    uid = await _pref.getString('uid');
    img = await _pref.getString('imgurl');





    setState(() {});
  }

  @override
  void initState() {
   getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final themedata=Theme.of(context);
    return Scaffold( backgroundColor: AppColors.nyanza,
      appBar: AppBar(
        backgroundColor: AppColors.teal,
        title: AppText(data: "Your Profile",size: 16,color: Colors.white,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Center(
                child: SizedBox(
                  height: 240,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: img != null
                            ? NetworkImage(img!)
                            : AssetImage('assets/img/profile.png') as ImageProvider<Object>,
                        fit: BoxFit.cover, // You can adjust the BoxFit as needed
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [


                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(
                      child: InkWell(
                        onTap:(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Editprofilepage()),
                          );
                        },
                        child: AppText(
                          data: "Edit",
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:20),
                    child: AppText(
                      data: "Personal Info",
                      color: Colors.white,
                      size: 18,
                    ),
                  ),

                ],
              ),
             SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.only(left: 20,),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.person,color: Colors.white,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('${name}',
                          style: TextStyle(color: Colors.white,fontSize: 16),)
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Divider(
                  thickness: 1.5,
                  color: AppColors.btnPrimaryColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20,),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.phone,color: Colors.white,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(phone!,
                        style:TextStyle(color: Colors.white,fontSize: 16),),
                    )

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Divider(
                  thickness: 1.5,
                  color: AppColors.btnPrimaryColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20,),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.email_rounded,color: Colors.white,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(email!,
                        style: TextStyle(color: Colors.white,fontSize: 16),
                    ))

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Divider(
                  thickness: 1.5,
                  color: AppColors.btnPrimaryColor,
                ),
              ),
              SizedBox(height: 25,),


            ],
          ),
        ),
      ),
    );
  }


}
