import 'package:flutter/material.dart';
import 'package:news_api_app/Category/news/news_item.dart';
import 'package:news_api_app/Category/news/news_widget_view_model.dart';
import 'package:news_api_app/api/api_manager.dart';
import 'package:news_api_app/model/news_response.dart';
import 'package:news_api_app/model/source_response.dart';
import 'package:news_api_app/utils/color_app.dart';
import 'package:provider/provider.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key,required this.sources});
  final Sources sources;
  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  List<Articles> allArticles = [];
  bool isLoading = false;
  bool hasMore = true;
  int currentPage = 1;
  ScrollController scrollController = ScrollController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getSourcesBySourceId(widget.sources.id!);
    fetchNews();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMoreArticles();
      }
    });
  }
  NewsWidgetViewModel viewModel = NewsWidgetViewModel();
  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<NewsWidgetViewModel>(
          builder: (context, viewModel, child) {
            if(viewModel.errorMessage != null){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.errorMessage!,
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelLarge,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.getSourcesBySourceId(widget.sources.id!);
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorApp.grayColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * .01,
                        vertical: height * .001,
                      ),
                    ),
                    child: Text('Try Again', style: text.displayMedium),
                  ),
                ],
              );
            }if(viewModel.newsList == null){
              return Center(
                 child: CircularProgressIndicator(
                   color: ColorApp.grayColor,
                 ),
               );
            }else{
              return  isLoading && allArticles.isEmpty
                 ? const Center(child: CircularProgressIndicator())
                 : ListView.separated(
               controller: scrollController,
               itemCount: allArticles.length + (hasMore ? 1 : 0),
               separatorBuilder: (context, index) => const SizedBox(height: 8),
               itemBuilder: (context, index) {
                 if (index < allArticles.length) {
                   return NewsItem(articles: viewModel.newsList![index]);
                 } else {
                   return const Center(child: CircularProgressIndicator());
                 }
               }
              );
            }
            },
      )
    );
  }
  Future<void> fetchNews() async {
    setState(() {
      isLoading = true;
      currentPage = 1;
      hasMore = true;
    });

    try {
      final response = await ApiManager.getNewsBySourceId(
        widget.sources.id ?? '',
        page: currentPage,
      );

      if (response.status == "ok" && response.articles != null) {
        setState(() {
          allArticles = response.articles!;
        });
      } else {
        setState(() {
          allArticles = [];
        });
      }
    } catch (e) {
      allArticles = [];
    } finally {
      setState(() => isLoading = false);
    }
  }
  Future<void> loadMoreArticles() async {
    if (isLoading || !hasMore) return;

    setState(() => isLoading = true);
    currentPage++;

    try {
      final response = await ApiManager.getNewsBySourceId(
        widget.sources.id ?? '',
        page: currentPage,
      );

      if (response.status == "ok" && response.articles != null) {
        if (response.articles!.isEmpty) {
          hasMore = false;
        } else {
          allArticles.addAll(response.articles!);
          setState(() {});
        }
      } else {
        hasMore = false;
      }
    } catch (e) {
      hasMore = false;
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
//FutureBuilder<NewsResponse>(
//           future: ApiManager.getNewsBySourceId(widget.sources.id??''),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   color: ColorApp.grayColor,
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Something went wrong',
//                     style: Theme
//                         .of(context)
//                         .textTheme
//                         .labelLarge,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       ApiManager.getNewsBySourceId(widget.sources.id??'');
//                       setState(() {});
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: ColorApp.grayColor,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: width * .01,
//                         vertical: height * .001,
//                       ),
//                     ),
//                     child: Text('Try Again', style: text.displayMedium),
//                   ),
//                 ],
//               );
//             } else if (snapshot.data?.status != 'ok') {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     snapshot.data!.message!,
//                     style: Theme
//                         .of(context)
//                         .textTheme
//                         .labelLarge,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       ApiManager.getNewsBySourceId(widget.sources.id??'');
//                       setState(() {});
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Theme
//                           .of(context)
//                           .dividerColor,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: width * .01,
//                         vertical: height * .001,
//                       ),
//                     ),
//                     child: Text('Try Again', style: text.displayMedium),
//                   ),
//                 ],
//               );
//             }
//             var newsList = snapshot.data?.articles ?? [];
//
//             if (newsList.isEmpty) {
//               return Center(
//                 child: Text(
//                   'No articles available for this source.',
//                   style: Theme.of(context).textTheme.labelLarge,
//                 ),
//               );
//             }
//
//             return  isLoading && allArticles.isEmpty
//                 ? const Center(child: CircularProgressIndicator())
//                 : ListView.separated(
//               controller: scrollController,
//               itemCount: allArticles.length + (hasMore ? 1 : 0),
//               separatorBuilder: (context, index) => const SizedBox(height: 8),
//               itemBuilder: (context, index) {
//                 if (index < allArticles.length) {
//                   return NewsItem(articles: allArticles[index]);
//                 } else {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//               }
//             );
//                 }
//             ),

