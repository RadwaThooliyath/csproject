import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/screens/HOD/registerdetails.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterdEvents extends StatefulWidget {
  var id;
   RegisterdEvents({super.key,this.id});

  @override
  State<RegisterdEvents> createState() => _RegisterdEventsState();
}

class _RegisterdEventsState extends State<RegisterdEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title:  Text("Events")),

        body: SafeArea(
          child: Container(
              child:  StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("registerevents").
                  where("status",isEqualTo: 1).where('createdby',isEqualTo: widget.id).
                  snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if(!snapshot.hasData){
                      // still waiting for data to come
                      return Center(child: CircularProgressIndicator());

                    }
                    else if(snapshot.hasData &&  snapshot.data!.docs.length==0) {
                      // got data from snapshot but it is empty

                      return Center(child: Text("No Data found"));
                    }
                    else
                      return ListView.builder(
                        itemCount:snapshot.data!.docs.length ,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(top: 20,left: 20,bottom: 20),
                            child: Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width*80,
                              color: Colors.white,
                              child: ListTile(
                                leading: CircleAvatar(radius: 15,child: Text('${index+1}'),),
                                title: Text(snapshot.data!.docs[index]['student'],style: TextStyle(color: Colors.black),),
                                subtitle: Text(snapshot.data!.docs[index]['title'],style: TextStyle(color: Colors.black),),
                                trailing: IconButton(onPressed: (){
                                  _makePhoneCall(snapshot.data!.docs[index]['phno']);
                                },
                                icon: Icon(Icons.phone,color: Colors.green,),
                                ),

                              ),
                            ),
                          );


                        },

                      );
                  }
              ) ,
          ),
        ));
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);


  }

}
