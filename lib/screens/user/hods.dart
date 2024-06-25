import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:csproject/utils/nodata_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class HODS extends StatefulWidget {
  const HODS({super.key});

  @override
  State<HODS> createState() => _HODSState();
}

class _HODSState extends State<HODS> {
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
                stream: FirebaseFirestore.instance.collection('hod').where('status',isEqualTo:1).snapshots(),
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
                                : AppColors.rustyred,
                            child: Container(
                              width: 250,
                              height: 150,
                              margin: EdgeInsets.only(bottom: 8),
                              padding: EdgeInsets.only(left: 15,right: 15,bottom: 5,top: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                  color: hod['status'] == 0
                                      ? Colors.grey
                                      : AppColors.contColor2
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

                                      IconButton(
                                      onPressed: () {
                                       _makePhoneCall(hod['phone']);
                                      },
                                      icon: CircleAvatar(child: Icon(Icons.call,color: AppColors.btnColor,)))

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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }
}
