import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/common/validate.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/constants/data.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
class EventRegister extends StatefulWidget {
  var title;
  var discription ;
  var time;
  var date;
  var venu;
  var organisedby;
var createdid;
 EventRegister({super.key,this.organisedby,this.venu,this.date,this.discription,this.title,this.time,this.createdid});

  @override
  State<EventRegister> createState() => _EventRegisterState();
}

class _EventRegisterState extends State<EventRegister> {
  TextEditingController _name=TextEditingController();
  TextEditingController _sem=TextEditingController();
  TextEditingController _phno=TextEditingController();
  TextEditingController _email=TextEditingController();

  final _eventregister = GlobalKey<FormState>();
  String? department;
  String? sem;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: AppText(data: "Event Registration",color: Colors.white,size: 16,),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _eventregister,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  AppText(data: "Register for this event here..",color: Colors.white,size: 18,),
                 SizedBox(height: 20,),
                  TextFormField(

                    validator: (value) {
                      if (value!.isEmpty) {
                        return "this is mandatory";
                      }
                    },
                    controller: _name,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(

                        hintText: "Enter Name",
                        hintStyle: TextStyle(color: Colors.white54,fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white54)
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.white, width: 1))),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                     return validate.emailValidator(value!);
                    },
                    controller: _email,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(

                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white54,fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white54)
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.white, width: 1))),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      return validate.phnvalidator(value!);
                    },
                    controller: _phno,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(

                        hintText: "Contach No",
                        hintStyle: TextStyle(color: Colors.white54,fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white54)
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.white, width: 1))),
                  ),
                  SizedBox(height: 20,),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white54,fontSize: 14),

                        enabledBorder: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white, width: 1)
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Colors.white, width: 1))
                    ),
                    style: TextStyle(color: Colors.blue),

                    hint: Text("Select department",style: TextStyle(color: Colors.white54),),

                    isExpanded: true,
                    value: department,
                    onChanged: (value) {
                      setState(() {
                        department = value;
                      });
                    },
                    items: departments.map((dept) {
                      return DropdownMenuItem<String>(
                        value: dept,
                        child: Text(dept.toString()),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20,),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white54,fontSize: 14),

                        enabledBorder: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white, width: 1)
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                            BorderSide(color: Colors.white, width: 1))
                    ),
                    style: TextStyle(color: Colors.blueAccent),

                    hint: Text("Select Semester",style: TextStyle(color: Colors.white54),),

                    isExpanded: true,
                    value: sem,
                    onChanged: (value) {
                      setState(() {
                        sem = value;
                      });
                    },
                    items: semester.map((dept) {
                      return DropdownMenuItem<String>(
                        value: dept,
                        child: Text(dept.toString()),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10,),

                  Center(
                    child: InkResponse(
                      splashColor:AppColors.rustyred.withOpacity(0.5),
                      onTap: () {
                        if (_eventregister.currentState!.validate()) {
                          final eventId=Uuid().v1();

                          FirebaseFirestore.instance.collection('registerevents').doc(eventId).set({
                          'student':_name.text,
                            'studentph':_email.text,
                            'department':department,
                            'sem':sem,
                            'status':1,
                            'createdat':DateTime.now(),
                            'title':widget.title,
                            'description':widget.discription,
                            'createdby':widget.createdid,
                            'date':widget.date,
                            'time':widget.time,
                            'venue':widget.venu,
                            'organisedby':widget.organisedby,
                            'phno':_phno.text

                          }).then((value) => Navigator.pop(context));

                        }
                      },
                      child: Container(
                        height: 48,
                        width: 250,
                        decoration: BoxDecoration(
                            color: AppColors.rustyred,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(child: Text("Register",
                          style: TextStyle(color: Colors.white),)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showsnackbar(String value){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value)));
  }

}
