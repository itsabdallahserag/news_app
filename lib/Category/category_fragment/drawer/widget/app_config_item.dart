import 'package:flutter/material.dart';
import 'package:news_api_app/utils/assests_app.dart';
import 'package:news_api_app/utils/color_app.dart';
import 'package:news_api_app/utils/text_app.dart';

class AppConfigItem extends StatelessWidget {
   const AppConfigItem({super.key,required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width*.04,vertical: height*.015),
      margin: EdgeInsets.only(top: height*.015),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorApp.whiteColor,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,style: TextApp.medium20White,),
          Image.asset(AssetsApp.arrowDown,width: width*.03,)
        ],
      ),
    );
  }
}
