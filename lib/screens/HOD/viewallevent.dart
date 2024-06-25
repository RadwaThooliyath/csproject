import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:csproject/utils/nodata_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewEventshod extends StatefulWidget {
  const ViewEventshod({super.key});

  @override
  State<ViewEventshod> createState() => _ViewEventshodState();
}

class _ViewEventshodState extends State<ViewEventshod> {
  String? _type;
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? eventType;

  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _type = await _pref.getString('type');
    email = await _pref.getString('email');
    name = await _pref.getString('name');
    phone = await _pref.getString('phone');
    uid = await _pref.getString('id');

    setState(() {});
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print(uid);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: AppText(data:"View Events",color: Colors.white,size: 16,),
        ),
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.all(20),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('events')
                    .where('hodid', isEqualTo: uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Somethign went wrong"),
                    );
                  }
                  if(snapshot.hasData &&  snapshot.data!.docs.length==0) {
                    // got data from snapshot but it is empty

                    return NoDataWidget(errorMessage: "No Events Added");
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final event = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: Container(
                              width: 250,
                              height: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: event['approvalsatus'] == 0
                                    ? LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                            AppColors.nyanza,
                                            AppColors.flashwhite
                                          ])
                                    : LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                        colors: [
                                            
                                            AppColors.teal,
                                          AppColors.flashwhite,
                                          ]),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText(
                                              data:"${event['title']}",
                                              color: Colors.white,
                                              size: 18,
                                            )
                                          ],
                                        ),
                                        AppText(data:"${event['description']}",color: Colors.white,),
                                       AppText(data:"${event['contactNumber']}",color: Colors.white,),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        AppText(data:"${event['eventDateandTime']}",color: Colors.white,),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            event['approvalsatus'] == 1
                                                ? AppText(data:"Approved",color: Colors.white,)
                                                : AppText(data:"Approval Pending",color: Colors.red,),
                                            SizedBox(width: 10,),
                                            if (event['status'] == 0)
                                              (event['approvalsatus'] == 0)
                                                  ? IconButton(
                                                      onPressed: () {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'events')
                                                            .doc(event[
                                                                'eventid'])
                                                            .delete();
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: AppColors.rustyred
                                                      ))
                                                  : SizedBox()
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return Center(
                    child: Text("Some unkonw error occured"),
                  );
                },
              )),
        ));
  }
}
