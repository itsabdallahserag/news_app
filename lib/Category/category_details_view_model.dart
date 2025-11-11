import 'package:flutter/material.dart';
import 'package:news_api_app/api/api_manager.dart';
import 'package:news_api_app/model/source_response.dart';

class CategoryDetailsViewModel extends ChangeNotifier{
  List<Sources>? sourcesList;
  String? errorMessage ;
  void getSources(String categoryId)async{
    sourcesList =null;
    errorMessage = null;
    notifyListeners();
    try{
      var sourceResponce = await ApiManager.getSources(categoryId: categoryId);
      //in error
      if(sourceResponce.status == 'error'){
        errorMessage = sourceResponce.message ;
      }
      //in Succes
      else{
        sourcesList = sourceResponce.sources;
      }
    }catch(e){
       errorMessage = e.toString() ;
    }
    notifyListeners();
  }
}