import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:flutter/material.dart';

class AllMemos extends StatefulWidget {
  var dept;
  AllMemos({super.key,this.dept});

  @override
  State<AllMemos> createState() => _AllMemosState();
}

class _AllMemosState extends State<AllMemos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: AppText(data: "View Memos",color: Colors.white,size: 16,),
        ),
        body: SafeArea( 
          child: Container(
            padding: EdgeInsets.all(20),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("memos").
                where("status",isEqualTo: 1).where('department',isEqualTo: widget.dept).
                snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if(!snapshot.hasData){
                    // still waiting for data to come
                    return Center(child: CircularProgressIndicator());
            
                  }
                  else if(snapshot.hasData &&  snapshot.data!.docs.length==0) {
                    // got data from snapshot but it is empty
            
                    return Center(child: AppText(data:"No Data found",color: Colors.white,size: 18,));
                  }
                  else
                    return ListView.builder(
                      itemCount:snapshot.data!.docs.length ,
                      itemBuilder: (context,index){
                        return Card(
                          color: AppColors.contColor2,
                          child: ListTile(
                            leading: CircleAvatar(radius: 15,child: Text('${index+1}'),),
                            title: Text(snapshot.data!.docs[index]['title']),
                            subtitle: Text(snapshot.data!.docs[index]['description']),
                          
                          
                          
                          
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
