

import 'package:csproject/constants/colors.dart';
import 'package:csproject/notification/models/feedbackmodel.dart';
import 'package:csproject/notification/services/feedbackservice.dart';
import 'package:csproject/utils/appbutton.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:csproject/utils/customcontainer.dart';
import 'package:csproject/utils/customtextformfiled.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:lottie/lottie.dart';

class ViewAllFeedbackAdmin extends StatefulWidget {
  String?userid;

  ViewAllFeedbackAdmin({Key? key,this.userid }) : super(key: key);

  @override
  State<ViewAllFeedbackAdmin> createState() => _ViewAllFeedbackAdminState();
}

class _ViewAllFeedbackAdminState extends State<ViewAllFeedbackAdmin> {

  FeedbackService _feedbackService=FeedbackService();
  TextEditingController _replyController = TextEditingController();

  //..............End of  TextEditing Controllers......................

  //----------Form key........................
  final _replyKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: AppText(
          data: "All Feedbacks",
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _feedbackService.getallFeedbacks(),
            builder: (context, snapshot) {

              if(snapshot.hasData && snapshot.data!.length==0){

                return Center(
                  child: Lottie.asset('assets/json/nodata.json',height: 190,width: 190),
                );

              }

              if (snapshot.hasData) {
                List<FeedbackModel> message=
                snapshot.data as List<FeedbackModel>;

                return ListView.builder(
                    itemCount: message.length,
                    itemBuilder: (context, index) {
                      var msg = message[index];
                      print(msg.title);
                      return Padding(
                        padding:
                        const EdgeInsets.only(right: 10, left: 10, top: 20),
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: CustomContainer(
                            ontap: () {},
                            height: 150,
                            width: 220,
                            decoration: BoxDecoration(
                                color: AppColors.scaffoldColor.withBlue(55),
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(
                              children: [
                          
                                msg.replystatus==0? Positioned(
                                  top: 10,
                                  right: 20,
                                  child: IconButton(onPressed: (){
                          
                                    showDialog(context: context, builder: (context){
                          
                                      return AlertDialog(
                                        backgroundColor: AppColors.scaffoldColor,
                                        title: AppText(data: "Feedback Reply",color: Colors.white,),
                                        //backgroundColor: AppColors().primaryColor,
                                        content: Container(
                                          height: 200,
                                          width: MediaQuery.of(context).size.width,
                          
                                          child: Form(
                                            key: _replyKey,
                                            child: Column(
                                              children: [
                          
                                                CustomTextFormField(
                                                  maxlines: 3,
                                                  controller: _replyController,
                                                  hintText: 'Enter a Reply',
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please enter a Reply';
                                                    }
                                                    return null;
                                                  },
                                                  enabledBorder: const UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.grey),
                                                  ),
                                                  focusedBorder: const UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.blue),
                                                  ),
                          
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Center(
                                                  child: AppButton(
                                                    onTap: () {
                                                      if (_replyKey.currentState!.validate()) {
                                                        FeedbackModel _message=FeedbackModel(
                                                            msgid: msg.msgid,
                          
                          
                          
                                                            reply: _replyController.text
                                                        );
                                                        _feedbackService.updateFeedback(_message).then((value) => Navigator.pop(context));
                          
                                                      }
                                                    },
                          
                                                    child: Center(child: AppText(data: "Send Reply",color: Colors.black,)),
                                                    height: 45,
                                                    width: 250,
                                                  ),
                                                )
                          
                          
                          
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  }, icon:FaIcon(FontAwesomeIcons.message,color: Colors.white,)),
                                ):Positioned(
                                  top: 75,right: 20,
                                    child: FaIcon(FontAwesomeIcons.check,color: Colors.green,)),
                          
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: msg.replystatus==0?AppColors.contColor4:Colors.green,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                          
                                    child: msg.replystatus==0?Center(child: AppText(data: "Reply Pending",color: Colors.white,)):
                                    Center(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AppText(data: "Replied: ${msg.reply}",color: Colors.white,),
                                    ))
                                    ,
                          
                                  ),
                                ),
                          
                                Positioned(
                                    top: 25,
                                    left: 20,
                                    right: 10,
                                    child: AppText(
                                      size: 16,
                                      fw: FontWeight.bold,
                                      data: "${msg.title}",
                                      color: Colors.white,
                                    )),
                                Positioned(
                                    top: 48,
                                    left: 20,
                                    right: 10,
                                    child: AppText(
                                      data: "${msg.message}",
                                      color: Colors.white,
                                    )),
                          
                                Align(
                                    alignment: Alignment.topRight,
                                    child: msg.status == 1
                                        ? IconButton(
                                        onPressed: (){
                          
                          
                                          _feedbackService.deleteFeedback(msg.msgid);
                                          setState(() {
                          
                                          });
                          
                          
                                        },
                                        icon: FaIcon(
                          
                                          FontAwesomeIcons.trash,
                                          color: Colors.red,
                                          size: 20,
                                        ))
                                        : SizedBox()
                                ),
                          
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }

              return Center(
                child: Text("no data"),
              );
            }),
      ),
    );
  }


}
