import 'package:flutter/material.dart';
import 'package:news_api_app/api/api_manager.dart';
import 'package:news_api_app/model/news_response.dart';

class NewsWidgetViewModel extends ChangeNotifier{
List<Articles>? newsList ;
String? errorMessage ;
void getSourcesBySourceId(String sourceId)async{
  newsList = null ;
  errorMessage = null ;
  notifyListeners();
  try{
    var newsRespnce =await ApiManager.getNewsBySourceId(sourceId);
    if(newsRespnce.status == 'error'){
      errorMessage = newsRespnce.message ;
    }else{
      newsList = newsRespnce.articles ;
    }
  }catch(e){
    errorMessage = e.toString() ;
  }
}
}