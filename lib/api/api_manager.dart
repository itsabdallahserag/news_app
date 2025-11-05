import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_api_app/api/api_constants.dart';
import 'package:news_api_app/api/end_points.dart';
import 'package:news_api_app/model/news_response.dart';
import 'package:news_api_app/model/source_response.dart';
 // https://newsapi.org/v2/top-headlines/sources?apiKey=0288c2a69df348e68feb0be9e4269f12e
class ApiManager {
  static Future<Source> getSources ({required String categoryId})async{
    Uri uri = Uri.https(ApiConstants.baseUrl,EndPoints.sourceApi,
        {'apiKey': ApiConstants.apiKey,
          'category' : categoryId
        });
    try {
      var response = await http.get(uri);
      return Source.fromJson(jsonDecode(response.body));
    }catch(e){
      rethrow;
    }
  }
 // https://newsapi.org/v2/everything?q=bitcoin&apiKey=0288c2a69df348e68feb0be9e4269f12
  static Future<NewsResponse> getNewsBySourceId(
      String sourceId, {
        int page = 1,
        int pageSize = 20,
      }) async {
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      EndPoints.newsApi,
      {
        'apiKey': ApiConstants.apiKey,
        'sources': sourceId,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
        'language': 'en',
        'sortBy': 'publishedAt',
      },
    );

    try {
      var responseBody = await http.get(url);
      return NewsResponse.fromJson(jsonDecode(responseBody.body));
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse> getNewsByQuery(
    String query,{
    int page = 1,
    int pageSize = 20
  }) async {
    final uri = Uri.https(
      ApiConstants.baseUrl,
      EndPoints.newsApi,
      {
        'q': query,
        'apiKey': ApiConstants.apiKey,
        'language': 'en',
        'sortBy': 'publishedAt',
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      },
    );

    try {
      final response = await http.get(uri);
      return NewsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}