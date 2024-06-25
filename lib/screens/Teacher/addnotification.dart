import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/constants/data.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddNotificationTeacher extends StatefulWidget {
  var name;
  var id;
  AddNotificationTeacher({super.key, this.id, this.name});

  @override
  State<AddNotificationTeacher> createState() => _AddNotificationTeacherState();
}

class _AddNotificationTeacherState extends State<AddNotificationTeacher> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  var v1;
  var uuid = Uuid();
  @override
  void initState() {
    v1 = uuid.v1();
    super.initState();
  }

  final _addnotification = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.teal,
        title: AppText(
          data: "Add Notifications",
          color: Colors.white,
          size: 16,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Form(
            key: _addnotification,
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
                          child: AppText(
                            data: "Add Notification here..",
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 14),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
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
                          controller: _descriptionController,
                          decoration: InputDecoration(
                              hintText: "Enter Message",
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 14),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: Colors.white54)),
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
                        InkResponse(
                          splashColor: AppColors.rustyred.withOpacity(0.5),
                          onTap: () {
                            if (_addnotification.currentState!.validate()) {
                              FirebaseFirestore.instance
                                  .collection('notification')
                                  .doc(v1)
                                  .set({
                                'title': _titleController.text,
                                'description': _descriptionController.text,
                                'status': 1,
                                'createdat': DateTime.now(),
                                'createdby': widget.name,
                                'createdid': widget.id,
                                'id': v1
                              }).then((value) {
                                Navigator.pop(context);
                                showsnackbar("Succesfully added");
                              });
                            }
                          },
                          child: Center(
                            child: Container(
                              height: 48,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: AppColors.rustyred,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                  child: Text(
                                "Add",
                                style: TextStyle(color: Colors.white),
                              )),
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

  void showsnackbar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value),
        backgroundColor: AppColors.teal,
      ),
    );
  }
}
