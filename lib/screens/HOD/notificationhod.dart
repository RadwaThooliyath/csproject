import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:csproject/utils/nodata_widget.dart';
import 'package:flutter/material.dart';

class ViewNotificationHod extends StatefulWidget {
  var id;
  ViewNotificationHod({super.key,this.id});

  @override
  State<ViewNotificationHod> createState() => _ViewNotificationHodState();
}

class _ViewNotificationHodState extends State<ViewNotificationHod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.teal,
          title:AppText(data: "All Notifications",color: Colors.white,size: 16,),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("notification").
                where("status",isEqualTo: 1).
                snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if(!snapshot.hasData){
                    // still waiting for data to come
                    return Center(child: CircularProgressIndicator());

                  }
                  else if(snapshot.hasData &&  snapshot.data!.docs.length==0) {
                    // got data from snapshot but it is empty

                    return NoDataWidget(errorMessage: "No Notification Added");
                  }
                  else
                    return ListView.builder(
                      itemCount:snapshot.data!.docs.length ,
                      itemBuilder: (context,index){
                        return Card(
                          color: AppColors.flashwhite,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.rustyred,
                              radius: 15,child: AppText(data:'${index+1}',color: Colors.white,),),
                            title: Text(snapshot.data!.docs[index]['title'],style: TextStyle(color: Colors.black),),
                            subtitle: Text(snapshot.data!.docs[index]['description']),
                            trailing: IconButton(onPressed: (){

                              FirebaseFirestore.instance.collection('notification').doc(snapshot.data!.docs[index]['id']).update({
                                'status':0
                              });
                            },
                              icon: Icon(Icons.delete,color: AppColors.rustyred,),
                            ),

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
