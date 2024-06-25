import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:csproject/utils/nodata_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewTeacher extends StatefulWidget {
  var dep;
 ViewTeacher({super.key,this.dep});

  @override
  State<ViewTeacher> createState() => _ViewTeacherState();
}

class _ViewTeacherState extends State<ViewTeacher> {

  @override
  void initState() {
    print(widget.dep);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.teal,
          title: AppText(data:"View Teachers",color: Colors.white,size: 16,),
        ),
        body: SafeArea(
          child: Container(padding: EdgeInsets.all(20),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('teacher').where('department',isEqualTo: widget.dep).snapshots(),
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

                  if(snapshot.hasData &&  snapshot.data!.docs.length==0) {
                    // got data from snapshot but it is empty

                    return NoDataWidget(errorMessage: "No Teachers Added");
                  }

                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final teacher = snapshot.data!.docs[index];
                        return Card(
                          child:Container(
                         
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: teacher['status'] == 0
                                  ? LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    AppColors.flashwhite,
                                    AppColors.nyanza
                                  ])
                                  : LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [

                                    AppColors.teal,
                                    AppColors.flashwhite,
                                  ]),
                            ),

                            child: Stack(
                              children: [

                                Positioned(
                                  top: 10,
                                  right: 120,
                                  child: SizedBox(

                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: teacher['imgurl']!= ""
                                              ? NetworkImage(teacher['imgurl']!)
                                              : AssetImage('assets/img/profile.png')
                                          as ImageProvider<Object>,
                                          fit: BoxFit
                                              .cover, // You can adjust the BoxFit as needed
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 40,
                                  left: 10,
                                  child: AppText(
                                    data:"${teacher['name']}",
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                    right: 10,
                                    child: Container(
                                        decoration: BoxDecoration(color: AppColors.rustyred,borderRadius: BorderRadius.circular(10)),
                                        padding: EdgeInsets.all(10),
                                        
                                        child: AppText(data: "${teacher['department']}",color: Colors.white,))),

                                Positioned(
                                    top: 60,
                                    left: 10,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.800,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                       
  
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText(data: "${teacher['phone']}",color: Colors.white,),
                                           Container(
                                             child: Row(
                                               children: [
                                                 IconButton(onPressed: (){

                                                   _makePhoneCall("${teacher['phone']}");

                                                 }, icon: CircleAvatar(child: Icon(Icons.call,color: AppColors.teal,)))
                                                 ,teacher['status'] == 1
                                                     ? CircleAvatar(
                                                   child: IconButton(
                                                       onPressed: () {
                                                         FirebaseFirestore.instance
                                                             .collection('teacher')
                                                             .doc(teacher['uid'])
                                                             .update({'status': 0});
                                                       },
                                                       icon: Icon(Icons.delete)),
                                                 )
                                                     : CircleAvatar(
                                                   child: IconButton(
                                                       onPressed: () {
                                                         FirebaseFirestore.instance
                                                             .collection('teacher')
                                                             .doc(teacher['uid'])
                                                             .update({'status': 1});
                                                       },
                                                       icon: Icon(
                                                         Icons.check,
                                                         color: Colors.green,
                                                       )),
                                                 )
                                               ],
                                             ),
                                           )

                                          ],
                                        ))),

                                Positioned(
                                    top: 100,
                                    left: 10,
                                    child: Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),


                                        child: AppText(data: "${teacher['email']}",color: Colors.white,))),


                              ],
                            ),
                          ) ,
                        );

                      },
                    );
                  }

                  return Center(
                    child: Text("Some unkonwn error occured"),
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
