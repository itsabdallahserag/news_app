import 'package:flutter/material.dart';
import 'package:news_api_app/utils/text_app.dart';

class DrawerWidget extends StatelessWidget {
   DrawerWidget({super.key,required this.imageName , required this.text});
  String imageName;
  String text;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      spacing: width*.025,
      children: [
        Image.asset(imageName,width: width*.065,),
        Text(text,style: TextApp.bold20White,)
      ],
    );
  }
}
