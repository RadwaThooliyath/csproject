import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:csproject/utils/nodata_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewEvents extends StatefulWidget {
  const ViewEvents({super.key});

  @override
  State<ViewEvents> createState() => _ViewEventsState();
}

class _ViewEventsState extends State<ViewEvents> {
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          title: AppText(data:"View Events",color:Colors.white,size: 16,),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
              child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('events').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if(snapshot.hasData && snapshot.data!.docs.length==0){
                return NoDataWidget(errorMessage: "No Events Added");
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text("Somethign went wrong"),
                );
              }

              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final event = snapshot.data!.docs[index];
                    return GestureDetector(
                      child: Card(
                        color: event['approvalsatus'] == 0
                            ? Colors.red
                            : Colors.green,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5),
                          padding: EdgeInsets.all(10),
                          width: 250,
                        
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: event['approvalsatus'] == 0
                                ? Colors.grey
                                : AppColors.appBarColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                event['approvalsatus'] == 1
                                    ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        AppText(data:"Approved",color: Colors.white,size: 14,),
                                      ],
                                    )
                                    : Row(
                        
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Approval Pending",style:TextStyle(color:Colors.white)),
                                    CircleAvatar(
                                      backgroundColor: Colors.green,
                                      child: IconButton(
                                          onPressed: () {
                        
                                            FirebaseFirestore.instance.collection('events').doc(event['eventid']).update({
                                              'approvalsatus':1
                                            });
                                          },
                                          icon: Icon(Icons.check,color: Colors.white,)),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                AppText(
                                  data:"${event['title']}",
                                 color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(
                                  height: 5,
                        
                                ),
                                AppText(data:"${event['description']}",color: Colors.white,size: 16,),
                                SizedBox(
                                  height: 5,
                                ),
                                AppText(data: "Contact: ${event['contactNumber']}",color: Colors.white,size: 16,),
                                SizedBox(
                                  height: 5,
                        
                                ),
                                AppText(data: "Date&Time: ${event['eventDateandTime']}",color: Colors.white,size: 16,),
                        
                        
                                SizedBox(
                                  height: 5,
                        
                                ),
                                AppText(data: "Organized By: ${event['organizedby']}",color: Colors.white,size: 16,),
                        
                        
                                SizedBox(
                                  height: 15,
                        
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
