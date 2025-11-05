import 'package:flutter/material.dart';
import 'package:news_api_app/Category/category_fragment/category.dart';
import 'package:news_api_app/Category/category_fragment/category_item.dart';
import 'package:news_api_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';

typedef OnCategoryItemClick = void Function(Category);
class CategoryFragment extends StatelessWidget {
   CategoryFragment({super.key, required this.onCategoryItemClick});
   List<Category> categoriesList = [];
   OnCategoryItemClick onCategoryItemClick;
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    categoriesList = Category.getCategories(themeProvider.appTheme == ThemeMode.dark ? false : true);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Good Morning\nHere is Some News For you',style: Theme.of(context).textTheme.labelLarge,),
            Expanded(child: ListView.separated(
              padding: EdgeInsets.only(top: height*.02),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      onCategoryItemClick(categoriesList[index]);
                    },
                      child: CategoryItem(category: categoriesList[index],index: index,));
                },
                separatorBuilder: (context, index) {
                 return SizedBox(height: height*.02,);
                },
                itemCount: categoriesList.length))
          ],
        ),
      );
  }
}
