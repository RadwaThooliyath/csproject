import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final double height;
  final double width;
  final String imgpath;
  const ImageWidget({
    super.key,required this.height,required this.width
  ,required this.imgpath
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('assets/images/$imgpath',height: height,width: width,),
    );
  }
}