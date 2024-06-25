import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:csproject/utils/nodata_widget.dart';
import 'package:flutter/material.dart';

class ViewNotificationTchr extends StatefulWidget {
  var id;
  ViewNotificationTchr({super.key,this.id});

  @override
  State<ViewNotificationTchr> createState() => _ViewNotificationTchrState();
}

class _ViewNotificationTchrState extends State<ViewNotificationTchr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          title: AppText(data:"View Notifications",color: Colors.white,size: 16,),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
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

                    return NoDataWidget(errorMessage: "No Notifications Added");
                  }
                  else
                    return ListView.builder(
                      itemCount:snapshot.data!.docs.length ,
                      itemBuilder: (context,index){
                        return Card(
                          color: AppColors.appBarColor,
                          child: ListTile(
                            leading: CircleAvatar(radius: 15,child: Text('${index+1}'),),
                            title: AppText(data:snapshot.data!.docs[index]['title'],color: Colors.white,),
                            subtitle:  AppText(data:snapshot.data!.docs[index]['description'],color: Colors.white,size: 14,),
                            trailing: IconButton(onPressed: (){

                              FirebaseFirestore.instance.collection('notification').doc(snapshot.data!.docs[index]['id']).update({
                                'status':1
                              });
                            },
                              icon: Icon(Icons.delete,color: AppColors.btnColor,),
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
