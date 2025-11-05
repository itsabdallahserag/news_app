import 'package:flutter/material.dart';
import 'package:news_api_app/Category/category_fragment/category.dart';
import 'package:news_api_app/Category/widget/source_tapBar_widget.dart';
import 'package:news_api_app/api/api_manager.dart';
import 'package:news_api_app/model/source_response.dart';
import 'package:news_api_app/utils/color_app.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key,required this.category});
  final Category category;
  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}
class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder<Source>(
      future: ApiManager.getSources(categoryId: widget.category.id,),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: ColorApp.grayColor),
          );
        } else if (snapshot.hasError) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  ApiManager.getSources(categoryId: widget.category.id);
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
        } else if (snapshot.hasData && snapshot.data?.status != 'ok') {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                snapshot.data?.message ?? 'Error occurred',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  ApiManager.getSources(categoryId: widget.category.id);
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).dividerColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * .01,
                    vertical: height * .001,
                  ),
                ),
                child: Text('Try Again', style: text.displayMedium),
              ),
            ],
          );
        }
        var sourcesList = snapshot.data?.sources ?? [];
        return SourceTapBarWidget(sourcesList: sourcesList);
      },
    );
  }
}
