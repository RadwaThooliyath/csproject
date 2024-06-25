import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/common/login_page.dart';
import 'package:csproject/common/registration_page.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/screens/HOD/addevents.dart';
import 'package:csproject/screens/HOD/addmemos.dart';
import 'package:csproject/screens/HOD/addnotifiction.dart';
import 'package:csproject/screens/HOD/addtchr.dart';
import 'package:csproject/screens/HOD/notificationhod.dart';
import 'package:csproject/screens/HOD/registeredevents.dart';
import 'package:csproject/screens/HOD/viewall_students.dart';
import 'package:csproject/screens/HOD/viewallevent.dart';
import 'package:csproject/screens/HOD/viewallmemos.dart';
import 'package:csproject/screens/HOD/viewteacher.dart';
import 'package:csproject/screens/admin/viewEvents.dart';
import 'package:csproject/screens/admin/viewHOD.dart';
import 'package:csproject/screens/admin/viewMemos.dart';
import 'package:csproject/screens/admin/viewtchr.dart';
import 'package:csproject/screens/user/events.dart';
import 'package:csproject/settings/settings_page.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:csproject/utils/customcontainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../admin/viewNotification.dart';

class HODHome extends StatefulWidget {
  final DocumentSnapshot? data;
  const HODHome({super.key,this.data});

  @override
  State<HODHome> createState() => _HODHomeState();
}

class _HODHomeState extends State<HODHome> {

  String? _type;
  String?uid;
  String?name;
  String?email;
  String?phone;
  String?dep;


  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _type = await _pref.getString('type');
    email= await _pref.getString('email');
    name = await _pref.getString('name');
    phone = await _pref.getString('phone');
    uid = await _pref.getString('id');

    dep = await _pref.getString('dept');
    setState(() {});
  }
  @override
  void initState() {

  getData();
print(dep);
  }

  @override
  Widget build(BuildContext context) {
    print(dep);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.rustyred,
        title: AppText(data:"CollegeHub",color: Colors.white,size: 16,),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Settingpage()));

          }, icon: Icon(Icons.settings))
        ],
      ),
      drawer: Drawer(
        backgroundColor:Colors.teal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(data:'$name',color: Colors.white,fw: FontWeight.w400,size: 17,),
                        AppText(data:'$email',color: Colors.white,fw: FontWeight.w400,size: 17,),
                      ],
                    )

                  ],
                )),
            ListTile(
              trailing: IconButton(onPressed: ()async{

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterdEvents(id:uid)));
              },
                icon: Icon(Icons.arrow_forward_ios,color: Colors.white,),),
              title: AppText(data: "Registred Events",color: Colors.white,),
            ),

            ListTile(
              trailing: IconButton(onPressed: ()async{

                SharedPreferences _pref =
                await SharedPreferences.getInstance();

                _pref.clear();
                FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Loginpage()),
                            (route) => false));
              },
                icon: Icon(Icons.logout,color: Colors.white,),),
              title: AppText(data: "Logout",color: Colors.white,),
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: AppColors.nyanza,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Row(
              children: [
                Expanded(
                  child: CustomContainer(
                    decoration: BoxDecoration(color: AppColors.flashwhite),
                    width: MediaQuery.of(context).size.width,
                    height: 110,

                    ontap: (){},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomContainer(
                          height: 55,
                          color: AppColors.flashwhite,

                          padding: EdgeInsets.all(15),
                          width:MediaQuery.of(context).size.width,
                          ontap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => AddNotificationHOD(name: name,id: uid,)));
                          },
                          child: Text(
                            "Add Notification",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        CustomContainer(
                          height: 55,
                          color: AppColors.verdigris,
                          padding: EdgeInsets.all(15),
                          width:MediaQuery.of(context).size.width,
                          ontap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ViewNotificationHod(id: uid,)));
                          },
                          child: Text(
                            "View Notification",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
SizedBox(height: 25,),
            Divider(height: 1.2,color: AppColors.rustyred,indent: 20,endIndent: 20,),

            SizedBox(height: 25,),

            Row(
              children: [
                Expanded(
                  child: CustomContainer(
                    decoration: BoxDecoration(color: AppColors.flashwhite),
                    width: MediaQuery.of(context).size.width,
                    height: 110,

                    ontap: (){},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomContainer(
                          height: 55,
                          color: AppColors.flashwhite,

                          padding: EdgeInsets.all(15),
                          width:MediaQuery.of(context).size.width,
                          ontap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => AddMemos(id: uid,name: name,dept: widget.data?['department'],)));
                          },
                          child: Text(
                            "Add Memos",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        CustomContainer(
                          height: 55,
                          color: AppColors.verdigris,
                          padding: EdgeInsets.all(15),
                          width:MediaQuery.of(context).size.width,
                          ontap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ViewAllMemos(id:uid)));
                          },
                          child: Text(
                            "View Memos",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),



            SizedBox(height: 25,),
            Divider(height: 1.2,color: AppColors.rustyred,indent: 20,endIndent: 20,),

            SizedBox(height: 25,),

            Row(
              children: [
                Expanded(
                  child: CustomContainer(
                    decoration: BoxDecoration(color: AppColors.flashwhite),
                    width: MediaQuery.of(context).size.width,
                    height: 110,

                    ontap: (){},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomContainer(
                          height: 55,
                          color: AppColors.flashwhite,

                          padding: EdgeInsets.all(15),
                          width:MediaQuery.of(context).size.width,
                          ontap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => AddEvents(
                                  id: widget.data?['uid'],
                                )));
                          },
                          child: Text(
                            "Add Events",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        CustomContainer(
                          height: 55,
                          color: AppColors.verdigris,
                          padding: EdgeInsets.all(15),
                          width:MediaQuery.of(context).size.width,
                          ontap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ViewEventshod()));
                          },
                          child: Text(
                            "View Events",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25,),
            Divider(height: 1.2,color: AppColors.rustyred,indent: 20,endIndent: 20,),

            SizedBox(height: 25,),

            Row(
              children: [
                Expanded(
                  child: CustomContainer(
                    decoration: BoxDecoration(color: AppColors.flashwhite),
                    width: MediaQuery.of(context).size.width,
                    height: 110,

                    ontap: (){},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomContainer(
                          height: 55,
                          color: AppColors.flashwhite,

                          padding: EdgeInsets.all(15),
                          width:MediaQuery.of(context).size.width,
                          ontap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => UserRegistrationPage(dept:dep)));
                          },
                          child: Text(
                            "Add Student",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        CustomContainer(
                          height: 55,
                          color: AppColors.verdigris,
                          padding: EdgeInsets.all(15),
                          width:MediaQuery.of(context).size.width,
                          ontap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ViewAllStudents(dep:dep)));
                          },
                          child: Text(
                            "View Student",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),







          ],
        ),
      ),
    );
  }
}
