import 'package:csproject/constants/colors.dart';
import 'package:csproject/utils/apptext.dart';
import 'package:flutter/material.dart';


class DashboardItemWidget extends StatelessWidget {
  const DashboardItemWidget(
      {super.key,
        required this.onTap1,
        required this.onTap2,
        required this.titleOne,
        required this.titleTwo,this.color});
  final VoidCallback onTap1;
  final VoidCallback onTap2;

  final String titleOne;
  final String titleTwo;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color:color?? AppColors.contColor5, borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 0,
            bottom: 30,
            child: Container(height: 20, width: 5, color: AppColors.contColor1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkResponse(
                  onTap: onTap1,
                  child: Center(child: AppText(data: titleOne,color: Colors.white,)),
                ),
              ),
              Container(
                height: 40,
                width: 2,
                color: Colors.white,
              ),
              Expanded(
                child: InkResponse(
                  onTap: onTap2,
                  child: Center(child: AppText(data:titleTwo,color: Colors.white,)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}