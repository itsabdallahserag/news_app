import 'package:flutter/material.dart';
import 'package:news_api_app/Category/category_fragment/drawer/widget/app_config_item.dart';
import 'package:news_api_app/Category/category_fragment/drawer/widget/divider.dart';
import 'package:news_api_app/Category/category_fragment/drawer/widget/drawer_widget.dart';
import 'package:news_api_app/utils/assests_app.dart';
import 'package:news_api_app/utils/color_app.dart';
import 'package:news_api_app/utils/text_app.dart';
import 'package:provider/provider.dart';

import '../../../provider/theme_provider.dart';

class DrawerItem extends StatefulWidget {
   DrawerItem({super.key,required this.onDrawerItemClick});
  final VoidCallback onDrawerItemClick;
  int selectedIndex = 0;
  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  var height ;
  var width ;
  var themeProvider;
  @override
  Widget build(BuildContext context) {
     height = MediaQuery.of(context).size.height;
     width = MediaQuery.of(context).size.width;
     themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: height*0.25,
          width: double.infinity,
          color: ColorApp.whiteColor,
          child: Text('News App',style: TextApp.bold28Bold,),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width*.04,vertical: height*.02),
          child: Column(children: [
          InkWell(onTap:(){widget.onDrawerItemClick();},child: DrawerWidget(imageName: AssetsApp.home, text: 'Go To Home')),
          DividerItem(),
          DrawerWidget(imageName: AssetsApp.theme, text: 'Theme'),
          InkWell(onTap: (){Navigator.pop(context);themeBottomSheet();},child: AppConfigItem(text: 'Dark')),
          DividerItem(),
          DrawerWidget(imageName: AssetsApp.language, text: 'Language'),
          AppConfigItem(text: 'English'),
              ]
          ),
        )
      ],
    );
  }
  Future themeBottomSheet() {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(
            left: width * 0.04,
            right: width * 0.04,
            bottom: height * 0.03,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(horizontal: width*.03,vertical: height*.02),
          child: Column(
            spacing: height*.02,
            children: [
              InkWell(
                onTap:(){
                  themeProvider.changeThemeMode(ThemeMode.dark);
                },
                child: Row(children: [
                  Image.asset(AssetsApp.moon,width: width*.055,color:Theme.of(context).primaryColor),
                  SizedBox(width: width*.02,),
                  Text('Dark',style: Theme.of(context).textTheme.displayMedium,),
                  Spacer(),
                  themeProvider.appTheme == ThemeMode.dark ?
                  Image.asset(AssetsApp.check,width: width*.06,color:Theme.of(context).primaryColor):
                  SizedBox()
                ],),
              ),
              InkWell(
                onTap: (){
                  themeProvider.changeThemeMode(ThemeMode.light,);
                },
                child: Row(children: [
                  Image.asset(AssetsApp.sun,width: width*.055,color:Theme.of(context).primaryColor),
                  SizedBox(width: width*.02,),
                  Text('Light',style: Theme.of(context).textTheme.displayMedium,),
                  Spacer(),
                  themeProvider.appTheme == ThemeMode.light ?
                  Image.asset(AssetsApp.check,width: width*.06,color:Theme.of(context).primaryColor):
                  SizedBox()
                ],),
              ),
            ],
          ),
        );
      },
    );
  }
}
