import 'package:flutter/material.dart';
import 'package:news_api_app/Category/category_fragment/category.dart';
import 'package:news_api_app/utils/color_app.dart';

class CategoryItem extends StatelessWidget {
   CategoryItem({super.key , required this.category , required this.index});
  final Category category;
  int index;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadiusGeometry.circular(24)),
      child:
          Stack(
            alignment: (index %2 == 0)? Alignment.bottomRight:Alignment.bottomLeft,
              children: [
            Image.asset(category.image,fit: BoxFit.fill,width: double.infinity,),
            Container(
              margin: EdgeInsetsGeometry.symmetric(horizontal: width*.04,vertical: height*.03),
              width: width*.5,
              decoration: BoxDecoration(
                color: ColorApp.grayBgColor,
                borderRadius: BorderRadius.circular(84),
              ),
              child: Row(
                textDirection: (index %2 == 0)? TextDirection.ltr:TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(padding: EdgeInsetsGeometry.directional(start: width*.02)),
                  Text('View All',style: Theme.of(context).textTheme.bodyLarge,),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 25,
                    child:(index %2 == 0)? Icon(Icons.arrow_forward_ios_rounded,color: Theme.of(context).dividerColor,):
                    Icon(Icons.arrow_back_ios_rounded,color: Theme.of(context).dividerColor,)
                  )
                ],
              ),
            )
          ]),

    );
  }
}
