import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/screens/user/eventdetails.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:flutter/material.dart';

class AllEvents extends StatefulWidget {
  var id;
  var dept;
  AllEvents({super.key,this.id,this.dept});

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: AppText(data: "Up coming events",color: Colors.white,size: 16,),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("events").
                where("approvalsatus",isEqualTo: 1).where('dept',isEqualTo:widget.dept.toString()).
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
                        final event = snapshot.data!.docs[index];
                        return Card(
                          color: AppColors.appBarColor,
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => EventDetails(
                                    title: "${event['title']}",
                                    discription:"${event['description']}" ,
                                    date: "${event['eventDateandTime']}",
                                    organisedby: snapshot.data!.docs[index]['organizedby'],
                                    venu: "${event['venue']}",
                                    contactnumber: "${event['contactNumber']}",
                                    createdid:"${event['hodid']}" ,

                                  )));
                            },
                            leading: CircleAvatar(radius: 15,child: Text('${index+1}'),),
                            title: AppText(data:snapshot.data!.docs[index]['title'],color: Colors.white,),
                            subtitle: AppText(data:snapshot.data!.docs[index]['description'],color: Colors.white,),
                            // trailing: IconButton(onPressed: (){
                            //
                            //   FirebaseFirestore.instance.collection('notification').doc(snapshot.data!.docs[index]['id']).update({
                            //     'status':1
                            //   });
                            // },
                            //   icon: Icon(Icons.delete),
                            // ),

                          ),
                        );


                      },

                    );
                }
            ),
          ) ,
        ));
  }
}
