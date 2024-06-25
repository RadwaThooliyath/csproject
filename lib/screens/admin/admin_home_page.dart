import 'package:csproject/common/colors.dart';
import 'package:csproject/common/login_page.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/screens/HOD/addtchr.dart';
import 'package:csproject/screens/admin/addHOD.dart';
import 'package:csproject/screens/admin/viewEvents.dart';
import 'package:csproject/screens/admin/viewHOD.dart';
import 'package:csproject/screens/admin/viewMemos.dart';
import 'package:csproject/screens/admin/viewNotification.dart';
import 'package:csproject/screens/admin/viewtchr.dart';
import 'package:csproject/screens/user/hods.dart';
import 'package:csproject/screens/user/techers.dart';
import 'package:csproject/settings/settings_page.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:csproject/utils/dash_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  String? name;
  String? email;

  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    name = _pref.getString('name');
    email = _pref.getString('email');
    setState(() {});
  }

  @override
  void initState() {
    getData(); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: AppColors.appBarColor,
        title: Text(
          "CollegeHub",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      drawer: Drawer(
        backgroundColor: AppColors.scaffoldColor,
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
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      data: '$name',
                      color: Colors.white,
                      fw: FontWeight.w400,
                      size: 17,
                    ),
                    AppText(
                      data: '$email',
                      color: Colors.white,
                      fw: FontWeight.w400,
                      size: 17,
                    ),
                  ],
                )
              ],
            )),
            ListTile(
              trailing: IconButton(
                onPressed: () async {
                  SharedPreferences _pref =
                      await SharedPreferences.getInstance();

                  _pref.clear();
                  FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Loginpage()),
                          (route) => false));
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
              title: AppText(
                data: "Logout",
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardItemWidget(
                onTap1: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddHOD()));
                },
                onTap2: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewHOD()));
                },
                titleOne: "Add Hod",
                titleTwo: "View HoDs"),
            SizedBox(
              height: 20,
            ),
            DashboardItemWidget(
                onTap1: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewNotification()));
                },
                onTap2: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewMemos()));
                },
                titleOne: "Vew Notification",
                titleTwo: "View Memos"),

            SizedBox(
              height: 20,
            ),
            DashboardItemWidget(
                onTap1: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddTchr()));
                },
                onTap2: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewTeach()));
                },
                titleOne: "Add Teacher",
                titleTwo: "View Teacher"),

            SizedBox(
              height: 20,
            ),
            DashboardItemWidget(
                onTap1: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewEvents()));
                },
                onTap2: () {

                },
                titleOne: "Vew Events",
                titleTwo: ""),

          ],
        ),
      ),
    );
  }
}
