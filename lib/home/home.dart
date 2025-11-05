import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api_app/Category/category_details.dart';
import 'package:news_api_app/Category/category_fragment/category.dart';
import 'package:news_api_app/utils/app_routes.dart';
import '../Category/category_fragment/category_fragment.dart';
import '../Category/category_fragment/drawer/drawer.dart';
import '../utils/color_app.dart';

class Home extends StatefulWidget {
   Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.transparent,
        title: Text(
          selectedCategory == null ?
          'Home':selectedCategory!.title,style: Theme.of(context).textTheme.titleMedium,),
        centerTitle: true,
        leading: Builder(builder: (context) => IconButton(onPressed: (){
          Scaffold.of(context).openDrawer();
        }, icon: Icon(Icons.menu_rounded,color: Theme.of(context).dividerColor,),),),
        actions: [IconButton(onPressed: (){
          Navigator.pushNamed(context, AppRoutes.search);
        }, icon: Icon(CupertinoIcons.search),color: Theme.of(context).dividerColor,)],
        actionsPadding: EdgeInsetsGeometry.directional(end: width*.04),
      ),
      drawer: Drawer(
        backgroundColor: ColorApp.blackColor,
        child: DrawerItem(onDrawerItemClick: onDrawerItemClick,),
      ),
      body: selectedCategory == null ?
      CategoryFragment(onCategoryItemClick: onCategoryItemClick,)
      : CategoryDetails(category: selectedCategory!,)
    );
  }

  Category? selectedCategory;

  void onCategoryItemClick (Category newSelectedCategory){
    selectedCategory = newSelectedCategory;
    setState(() {});
  }
  void onDrawerItemClick (){
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}
