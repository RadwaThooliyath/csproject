


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csproject/constants/colors.dart';
import 'package:csproject/constants/data.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


class AddMemos extends StatefulWidget {
  var name;
  var id;
  var dept;
 AddMemos({super.key,this.id,this.name,this.dept});

  @override
  State<AddMemos> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddMemos> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionCpntroller = TextEditingController();


  var v1;
  var uuid=Uuid();
  @override
  void initState() {
    v1=uuid.v1();
    super.initState();
  }


  final _addevents = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.teal,
        title:AppText(data: "Add Memos",color: Colors.white,size: 16,),
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
                          child: AppText(data:"Add memos here..",color: Colors.white,size: 18,),
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
                          controller: _descriptionCpntroller,
                          decoration: InputDecoration(
                              hintText: "Enter Message",
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

                        InkResponse(
                          splashColor: AppColors.rustyred.withOpacity(0.5),
                          onTap: () {
                            if (_addevents.currentState!.validate()) {
                              FirebaseFirestore.instance.collection('memos').doc(v1).set({
                                'title':_titleController.text,
                                'description':_descriptionCpntroller.text,
                                'status':1,
                                'createdat':DateTime.now(),
                                'createdby':widget.name,
                                'createdid':widget.id,
                                'id':v1,
                                'department':widget.dept

                              }).then((value) {Navigator.pop(context);
                              showsnackbar("Succesfully added");});


                            }
                          },
                          child: Center(
                            child: Container(
                              height: 48,
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



