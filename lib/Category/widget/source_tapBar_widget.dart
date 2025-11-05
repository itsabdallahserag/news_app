import 'package:flutter/material.dart';
import 'package:news_api_app/Category/news/news_widget.dart';
import 'package:news_api_app/Category/widget/sources_name.dart';
import 'package:news_api_app/model/source_response.dart';
import 'package:news_api_app/utils/color_app.dart';

class SourceTapBarWidget extends StatefulWidget {
   SourceTapBarWidget({super.key,required this.sourcesList});
  final List<Sources> sourcesList;

  @override
  State<SourceTapBarWidget> createState() => _SourceTapBarWidgetState();
}

class _SourceTapBarWidgetState extends State<SourceTapBarWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
      return DefaultTabController(
        length: widget.sourcesList.length,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TabBar(
              tabAlignment: TabAlignment.start,
              dividerColor: ColorApp.transparent,
              indicatorColor: Theme.of(context).dividerColor,
              isScrollable: true,
              onTap: (index){
                selectedIndex = index;
                setState(() {});
              },
                tabs: widget.sourcesList.map((source){
              return SourcesName(sources: source,
                  isSelected: selectedIndex == widget.sourcesList.indexOf(source),);}).toList(),
            ),
            Expanded(child: NewsWidget(sources: widget.sourcesList[selectedIndex]))
          ],
        )
    );
  }
}
