import 'package:csproject/constants/colors.dart';
import 'package:csproject/screens/user/eventregister.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/customcontainer.dart';
class EventDetails extends StatefulWidget {
  var title;
  var discription ;
  var time;
  var date;
  var venu;
  var organisedby;
  var contactnumber;
  var createdid;
  var type;

   EventDetails({super.key,this.type,this.contactnumber,this.date,this.discription,this.organisedby,this.time,this.title,this.venu,this.createdid});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: AppText(data: "Event Details",color: Colors.white,size: 16,),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(data: "Title\n${widget.title}",size: 18,color: Colors.white,),
              ),

              Divider(height: 1,color: AppColors.rustyred,),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(data:"Description:\n${widget.discription}",color: Colors.white,size: 16,),
              ),
              Divider(height: 1,color: AppColors.rustyred,),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(data:"Date:${widget.date}",color: Colors.white,size: 16,),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text("Time:",style: TextStyle(fontSize: 23),),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(data:"Venue:\n${widget.venu}",color: Colors.white,size: 16,),
              ),

              Divider(height: 1,color: AppColors.rustyred,),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    AppText(data:"Contact Number:\n${widget.contactnumber}",color: Colors.white,size:
                      16,),
                    SizedBox(width: 50,),
                    CircleAvatar(
                      child: IconButton(
                        onPressed: (){
                          _makePhoneCall(widget.contactnumber);
                      
                        },
                        icon: Icon(Icons.call,color: Colors.green,),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(height: 1,color: AppColors.rustyred,),
              SizedBox(height: 5,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(data: "Organised By:\n Department of ${widget.organisedby}",size: 16,color: Colors.white,),
              ),

              SizedBox(height: 20,),

              Center(
                child: CustomContainer(
                  ontap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventRegister(
                              time: widget.time,
                              title: widget.title,
                              discription: widget.discription,
                              createdid: widget.createdid,
                              organisedby: widget.organisedby,
                              date: widget.date,
                              venu: widget.venu,
                            )));
                  },
                  decoration: BoxDecoration(
                    color: AppColors.rustyred,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  width:250,
                  child:Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(child: AppText(data:"Register Now",color: Colors.white,size: 16,),)),
                  ),
                ),



            ],
          ),
        ),
      ),
    );
  }
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);


  }

}
