import 'package:flutter/cupertino.dart';
import 'package:news_api_app/utils/assests_app.dart';

class Category {
  String id;
  String title;
  String image;
  Category({required this.id , required this.title , required this.image});
  static List<Category> getCategories(bool isDark){
    ///
   return [
      Category(id: 'general', title: 'General',
          image: isDark? AssetsApp.generalDark : AssetsApp.generalLight
      ),Category(id: 'business', title: 'Business',
          image: isDark? AssetsApp.businessDark : AssetsApp.businessLight
      ),Category(id: 'sports', title: 'Sports',
          image: isDark? AssetsApp.sportsDark : AssetsApp.sportsLight
      ),Category(id: 'health', title: 'Health',
          image: isDark? AssetsApp.healthDark : AssetsApp.healthLight
      ),Category(id: 'science', title: 'Science',
          image: isDark? AssetsApp.scienceDark: AssetsApp.scienceLight
      ),Category(id: 'entertainment', title: 'Entertainment',
          image: isDark? AssetsApp.entertainmentDark: AssetsApp.entertainmentLight
      ),Category(id: 'technology', title: 'Technology',
          image: isDark? AssetsApp.technologyDark : AssetsApp.technologyLight
      )
    ];
  }
}