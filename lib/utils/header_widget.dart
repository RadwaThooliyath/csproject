
import 'package:csproject/constants/colors.dart';
import 'package:flutter/material.dart';



class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(

      text:
      TextSpan(
          text:  "Never Stop\n",
          style: TextStyle(color: Colors.white,fontSize: 25,fontFamily: "Clash Display",fontWeight: FontWeight.w500)
          ,children: [
        TextSpan(
            text: "Learning ",
            style: TextStyle(color: AppColors.btnPrimaryColor,fontSize: 33,fontFamily: "Clash Display",fontWeight: FontWeight.w700)
        ),

        TextSpan(
            text: "Because Life \n",
            style: TextStyle(color: Colors.white,fontSize: 25,fontFamily: "Clash Display",fontWeight: FontWeight.w500)
        ),
        TextSpan(
            text: "Never Stops",
            style: TextStyle(color: Colors.white,fontSize: 25,fontFamily: "Clash Display",fontWeight: FontWeight.w500)
        ),
        TextSpan(
            text: " Teaching",
            style: TextStyle(color: AppColors.btnPrimaryColor,fontSize: 33,fontFamily: "Clash Display",fontWeight: FontWeight.w700)
        )
      ]),

    );
  }
}