import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:csproject/utils/nodata_widget.dart';
import 'package:flutter/material.dart';

class ViewHOD extends StatefulWidget {
  const ViewHOD({super.key});

  @override
  State<ViewHOD> createState() => _ViewHODState();
}

class _ViewHODState extends State<ViewHOD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          title: AppText(data:"View HODs",color: Colors.white,size: 16,),
        ),
        body: SafeArea(
          child: Container(
            height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('hod').snapshots(),
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

              if(snapshot.hasData && snapshot.data!.docs.length==0){
                return NoDataWidget(errorMessage: "No Hods Added");
              }

              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final hod = snapshot.data!.docs[index];
                    return GestureDetector(
                       child: Card(
                         color: hod['status'] == 0
                             ? Colors.red
                             : Colors.green,
                         child: Container(
                          width: 250,
                          height: 150,
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.only(left: 15,right: 15,bottom: 5,top: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            color: hod['status'] == 0
                                ? Colors.grey
                                : AppColors.appBarColor
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                         
                              CircleAvatar(child: AppText(data: "${index+1}",color: Colors.white,),),
                         
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      data:"${hod['name']}",
                                    size: 18,
                                      color: Colors.white,
                                      fw: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: 5,
                                
                                    ),
                                    AppText(data:"${hod['department']}", size: 16,
                                      color: Colors.white,
                                      fw: FontWeight.w700,),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    AppText(data:"${hod['email']}",color: Colors.white,size: 14,),
                                    SizedBox(
                                      height: 5,
                                
                                    ),
                                    AppText(data:"${hod['phone']}",color: Colors.white,size: 14,)
                                  ],
                                ),
                              ),
                              hod['status'] == 1
                                  ? IconButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('hod')
                                            .doc(hod['uid'])
                                            .update({'status': 0});
                                      },
                                      icon: CircleAvatar(child: Icon(Icons.delete,color: AppColors.btnColor,)))
                                  : IconButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('hod')
                                            .doc(hod['uid'])
                                            .update({'status': 1});
                                      },
                                      icon: CircleAvatar(
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                      ))
                            ],
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
