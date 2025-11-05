import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api_app/Category/news/news_item.dart';
import 'package:news_api_app/model/news_response.dart';
import '../../api/api_manager.dart';

class Search extends StatefulWidget {
  Search({super.key, this.articles});
  final List<Articles>? articles;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();
  List<Articles> allArticle = [];
  List<Articles> felteredArticle = [];
  bool isLoading = false;
  Timer? _debounce;
  int currentPage = 1;
  bool hasMore = true;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    fetchInitialNews();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMoreArticles();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * .04,
                vertical: height * .008,
              ),
              child: TextFormField(
                controller: controller,
                onChanged: searchArticle,
                style: Theme.of(context).textTheme.titleMedium,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: Theme.of(context).dividerColor,
                  ),
                  hintStyle: Theme.of(context).textTheme.titleMedium,
                  hintText: 'Search',
                  filled: false,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * .01),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : felteredArticle.isEmpty
                  ? const Center(child: Text('No results found'))
                  : ListView.separated(
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        if (index < felteredArticle.length) {
                          return NewsItem(articles: felteredArticle[index]);
                        } else {
                          return Visibility(
                            visible: isLoading,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          );
                        }
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 0),
                      itemCount: felteredArticle.length + 1,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void searchArticle(String query) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        setState(() {
          felteredArticle = allArticle;
        });
        return;
      }
      currentPage = 1;
      hasMore = true;
      allArticle.clear();
      felteredArticle.clear();

      setState(() {
        isLoading = true;
      });

      try {
        final response = await ApiManager.getNewsByQuery(
          query,
          page: currentPage,
        );
        if (response.status == 'ok' && response.articles != null) {
          setState(() {
            allArticle = response.articles!;
            felteredArticle = allArticle;
            isLoading = false;
          });
        } else {
          setState(() {
            felteredArticle = [];
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          felteredArticle = [];
          isLoading = false;
        });
      }
    });
  }

  Future<void> fetchInitialNews() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await ApiManager.getNewsByQuery("general");
      if (response.status == 'ok' && response.articles != null) {
        setState(() {
          allArticle = response.articles!;
          felteredArticle = allArticle;
          isLoading = false;
        });
      } else {
        setState(() {
          allArticle = [];
          felteredArticle = [];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        allArticle = [];
        felteredArticle = [];
        isLoading = false;
      });
    }
  }

  Future<void> loadMoreArticles() async {
    if (isLoading || !hasMore) return;

    setState(() => isLoading = true);
    currentPage++;

    try {
      final response = await ApiManager.getNewsByQuery(
        controller.text.isEmpty ? "general" : controller.text,
        page: currentPage,
      );

      if (response.status == 'ok' && response.articles != null) {
        if (response.articles!.isEmpty) {
          hasMore = false;
        } else {
          allArticle.addAll(response.articles!);
          felteredArticle = allArticle;
        }
      }
    } catch (e) {
      hasMore = false;
    } finally {
      setState(() => isLoading = false);
    }
  }
}
