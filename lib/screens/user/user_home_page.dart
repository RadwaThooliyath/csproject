import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/common/colors.dart';
import 'package:csproject/common/login_page.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/screens/admin/viewEvents.dart';
import 'package:csproject/screens/admin/viewMemos.dart';
import 'package:csproject/screens/admin/viewNotification.dart';
import 'package:csproject/screens/user/allmemo.dart';
import 'package:csproject/screens/user/allnotification.dart';
import 'package:csproject/screens/user/eventdetails.dart';
import 'package:csproject/screens/user/events.dart';
import 'package:csproject/screens/user/hods.dart';
import 'package:csproject/screens/user/techers.dart';
import 'package:csproject/settings/settings_page.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:csproject/utils/customcontainer.dart';
import 'package:csproject/utils/nodata_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHomePage extends StatefulWidget {
  final DocumentSnapshot? data;
  UserHomePage({super.key, this.data});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String? name;
  String? email;
  String? img;
  String? location;
  String? phone;
  String? dept;

  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    name = _pref.getString('name');
    email = _pref.getString('email');
    phone = _pref.getString('phone');
    img = _pref.getString('img');
    location = _pref.getString('location');
    dept = _pref.getString('dept');

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
        backgroundColor: AppColors.teal,
        title: AppText(
          data: "CollegeHub",
          color: Colors.white,
          size: 16,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settingpage()));
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.teal,
        child: SingleChildScrollView(
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
                        image: img != ""
                            ? NetworkImage(img!)
                            : AssetImage('assets/img/profile.png')
                                as ImageProvider<Object>,
                        fit:
                            BoxFit.cover, // You can adjust the BoxFit as needed
                      ),
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewTeacherUser()));
                },
                title: AppText(
                  data: "Teachers",
                  color: Colors.white,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => HODS()));
                },
                title: AppText(
                  data: "HODs",
                  color: Colors.white,
                ),
              ),
              ListTile(
                trailing: IconButton(
                  onPressed: () async {
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
      ),
      body: Container(
        color: AppColors.nyanza,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  data: 'Latest Memos',
                  color: Colors.white,
                  size: 18,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllMemos(
                                    dept: dept,
                                  )));
                    },
                    child: AppText(
                      data: 'View all',
                      color: Colors.white,
                      size: 16,
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('memos')
                    .limit(2)
                    .where('department', isEqualTo: dept)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Something went wrong"),
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.docs.length == 0) {
                    return Center(
                        child: AppText(
                      data: "No Memeos to Show",
                      color: Colors.white,
                      size: 14,
                    ));
                  }

                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final memos = snapshot.data!.docs[index];
                        return Card(
                          child: Container(
                            height: 150,
                            width: 280,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.rustyred.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.nyanza,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: EdgeInsets.all(10),
                                        child: AppText(
                                          data: "${memos['department']}",
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                                AppText(
                                  data: "${memos['title']}",
                                  color: Colors.white,
                                  size: 18,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        child: AppText(
                                      data: "${memos['description']}",
                                      color: Colors.white,
                                    ))),
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: AppText(
                                      data: "Posted By :${memos['createdby']}",
                                      color: Colors.white54,
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return Center(
                    child: Text("Some unkonwn error occured"),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  data: 'Latest Notifications',
                  color: Colors.white,
                  size: 18,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllNotification()));
                    },
                    child: AppText(
                      data: 'View all',
                      color: Colors.white,
                      size: 16,
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 125,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('notification')
                    .limit(2)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Something went wrong"),
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.docs.length == 0) {
                    return Center(
                        child: AppText(
                      data: "No Notifications to Show",
                      color: Colors.white,
                      size: 14,
                    ));
                  }

                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final notification = snapshot.data!.docs[index];
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                child: Container(
                              width: 250,
                              height: 135,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? AppColors.flashwhite
                                      : AppColors.verdigris,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      data: "${notification['title']}",
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    AppText(
                                      data: "${notification['description']}",
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ]),
                            )));
                      },
                    );
                  }

                  return Center(
                    child: Text("Some unkonwn error occured"),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  data: 'Upcoming Events',
                  color: Colors.white,
                  size: 18,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AllEvents()));
                    },
                    child: AppText(
                      data: 'View all',
                      color: Colors.white,
                      size: 16,
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 160,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("events").
                where("approvalsatus",isEqualTo: 1).where('dept',isEqualTo:dept.toString()).
                snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Something went wrong"),
                    );
                  }

                  if (snapshot.hasData && snapshot.data!.docs.length == 0) {
                    return Center(
                        child: AppText(
                      data: "No Events to Show",
                      color: Colors.white,
                      size: 14,
                    ));
                  }

                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final event = snapshot.data!.docs[index];
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                child: Container(
                              height: 100,
                              width: 280,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                      colors: [
                                        AppColors.contColor5,
                                        AppColors.contColor3
                                      ])),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 5,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${event['title']}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("${event['description']}"),
                                            ],
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 20,
                                      right: 20,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EventDetails(
                                                        title:
                                                            "${event['title']}",
                                                        discription:
                                                            "${event['description']}",
                                                        date:
                                                            "${event['eventDateandTime']}",
                                                        organisedby: snapshot
                                                                .data!
                                                                .docs[index]
                                                            ['organizedby'],
                                                        venu:
                                                            "${event['venue']}",
                                                        contactnumber:
                                                            "${event['contactNumber']}",
                                                        createdid:
                                                            "${event['hodid']}",
                                                        type: "${event['type']}",
                                                      )));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: AppColors.rustyred,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: AppText(
                                            data: 'View Details',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            )));
                      },
                    );
                  }

                  return Center(
                    child: Text("Some unkonwn error occured"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
