import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/common/login_page.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/screens/Teacher/addnotification.dart';
import 'package:csproject/screens/HOD/registeredevents.dart';
import 'package:csproject/screens/Teacher/viewevent_teacher.dart';
import 'package:csproject/screens/Teacher/viewmemostchr.dart';
import 'package:csproject/screens/Teacher/viewnotificationtechr.dart';
import 'package:csproject/screens/admin/viewEvents.dart';
import 'package:csproject/screens/admin/viewMemos.dart';
import 'package:csproject/screens/admin/viewNotification.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:csproject/utils/dash_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherHome extends StatefulWidget {

  final DocumentSnapshot? data;
  TeacherHome({super.key,this.data});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {


  String? _type;
  String?uid;
  String?name;
  String?email;
  String?phone;
  String?dep;
  String?img;


  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _type = await _pref.getString('type');
    email= await _pref.getString('email');
    name = await _pref.getString('name');
    phone = await _pref.getString('phone');
    uid = await _pref.getString('id');
    img = await _pref.getString('img');

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.teal,
        title: AppText(data:"CollegeHub",color: Colors.white,size: 16,),
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
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image:img!= ""
                              ? NetworkImage(img!)
                              : AssetImage('assets/img/profile.png')
                          as ImageProvider<Object>,
                          fit: BoxFit
                              .cover, // You can adjust the BoxFit as needed
                        ),
                      ),
                    ),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            DashboardItemWidget(
                color: AppColors.rustyred,
                onTap1: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddNotificationTeacher(name: name,id: uid,)));
            }, onTap2: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewNotification(
                    id: uid,
                  )));
            }, titleOne: "Add Notification", titleTwo: "View Notification")
            ,

            SizedBox(height: 20,),

            DashboardItemWidget(
              color: AppColors.nyanza,
                onTap1: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewAllMemosTchr(dept: dep)));
            }, onTap2: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewEventsTchr()));
            }, titleOne: "View Memos", titleTwo: "View Events")


          ],
        ),
      ),
    );
  }
}
