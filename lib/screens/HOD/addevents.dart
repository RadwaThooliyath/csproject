


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/constants/data.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


class AddEvents extends StatefulWidget {
  var id;
   AddEvents({super.key,required this.id});

  @override
  State<AddEvents> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddEvents> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateandtimeController = TextEditingController();
  TextEditingController _venuecontroller = TextEditingController();
  TextEditingController _organisedbycontroller = TextEditingController();
  TextEditingController _contactnumbercontroller = TextEditingController();

  String? _type;
  String?uid;
  String?name;
  String?email;
  String?phone;
  String?eventType;
  String?dept;

  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _type = await _pref.getString('type');
    email= await _pref.getString('email');
    name = await _pref.getString('name');
    phone = await _pref.getString('phone');
    uid = await _pref.getString('id');
    dept=await _pref.getString('dept');

    setState(() {});
  }
  @override
  void initState() {
    getData();

  }


  final _addevents = GlobalKey<FormState>();

  DateTime? _selectedDateTime;

  Future<void> _selectDateAndTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    print(uid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.teal,
        title:AppText(data: "Add Events",color: Colors.white,size: 16,),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        height: double.infinity,
        width: double.infinity,

        child: Form(
            key: _addevents,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: AppText(data:"Add Events here..",color: Colors.white,),
                        ),

                        SizedBox(height: 20,),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "this is mandatory";
                            }
                          },
                          controller: _titleController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(

                              hintText: "Enter Title",
                              hintStyle: TextStyle(color: Colors.white,fontSize: 14),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white54)
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1)))
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "this is mandatory";
                            }
                          },
                          controller: _descriptionController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(

                              hintText: "Enter Description",
                              hintStyle: TextStyle(color: Colors.white,fontSize: 14),
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
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          readOnly: true, // Prevents manual text input
                          onTap: () {
                            _selectDateAndTime(context);
                          },
                          validator: (value) {
                            if (_selectedDateTime == null) {
                              return "This field is mandatory";
                            }
                            return null;
                          },
                          controller: TextEditingController(
                            text: _selectedDateTime != null
                                ? "${_selectedDateTime!.toLocal()}"
                                : '', // Display selected date and time if available
                          ),
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "Select Date & Time",
                              hintStyle: TextStyle(color: Colors.white,fontSize: 14),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white54)
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1))
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "this is mandatory";
                            }
                          },
                          controller: _venuecontroller,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "Enter Venue",
                              hintStyle: TextStyle(color: Colors.white,fontSize: 14),
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
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "this is mandatory";
                            }
                          },
                          style: TextStyle(color: Colors.white),
                          controller: _organisedbycontroller,
                          decoration: InputDecoration(
                              hintText: "Organized By",
                              hintStyle: TextStyle(color: Colors.white,fontSize: 14),
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
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "this is mandatory";
                            }
                          },
                          controller: _contactnumbercontroller,
                          decoration: InputDecoration(
                              hintText: "Contact No",
                              hintStyle: TextStyle(color: Colors.white,fontSize: 14),
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

                        //todo  add more fields

                        SizedBox(
                          height: 20,
                        ),

                        DropdownMenu(
                          textStyle: TextStyle(color: Colors.white),
                          trailingIcon: Icon(color: Colors.white,Icons.arrow_drop_down),
                          inputDecorationTheme: InputDecorationTheme(

                              hintStyle: TextStyle(color: Colors.white,fontSize: 14),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white54)
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1))
                          ),
                          width: 250,
                          hintText: "Select Type",
                          onSelected: (event){


                            setState(() {
                              eventType=event;
                            });
                          },


                            dropdownMenuEntries: [

                          DropdownMenuEntry(value: "Public", label: "Public"),
                          DropdownMenuEntry(value: "Private", label: "Private")
                        ]),
                        SizedBox(
                          height: 20,
                        ),

                        InkResponse(
                          splashColor: Colors.orange.withOpacity(0.5),
                          onTap: () {
                            if (_addevents.currentState!.validate()) {
                            final eventId=Uuid().v1();

                            FirebaseFirestore.instance.collection('events').doc(eventId).set({
                              'title':_titleController.text,
                              'description':_descriptionController.text,
                              'status':0,
                              'eventDateandTime':_selectedDateTime,
                                'venue':_venuecontroller.text,
                              'organizedby':_organisedbycontroller.text,
                              'contactNumber':_contactnumbercontroller.text,
                              'eventid':eventId,
                              'hodid':uid,
                              'type':eventType,
                              'approvalsatus':0,
                              'dept':dept,
                              'createdat':DateTime.now()





                            }).then((value) => Navigator.pop(context));

                            }
                          },
                          child: Center(
                            child: Container(
                              height: 45,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: AppColors.rustyred,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(child: Text("Add",
                                style: TextStyle(color: Colors.white),)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),

                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );

  }
  void showsnackbar(String value){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value)));
  }

}



