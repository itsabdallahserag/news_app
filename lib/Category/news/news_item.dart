import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_api_app/model/news_response.dart';
import 'package:news_api_app/utils/color_app.dart';
import 'package:news_api_app/utils/text_app.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class NewsItem extends StatefulWidget {
  const NewsItem({super.key, required this.articles});
  final Articles articles;

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  var height ;
  var width ;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: showBottomSheet,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width*.04,vertical: height*.01),
        padding: EdgeInsets.symmetric(horizontal: width*.02,vertical: height*.01),
        decoration: BoxDecoration(
          color: ColorApp.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor,width: 2),
        ),
        child: Column(
          spacing: height*.014,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: widget.articles.urlToImage??'',
                placeholder: (context, url) => Center(child:
                CircularProgressIndicator(color:ColorApp.grayColor,)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Text(widget.articles.title??'',style: Theme.of(context).textTheme.labelMedium,),
            Row(
              children: [
                Expanded(child: Text("By: ${widget.articles.author??''}",style: TextApp.medium12gray,)),
                Text(formatPublished(widget.articles.publishedAt??''),style: TextApp.medium12gray,)
              ],
            )
          ],
        ),
      ),
    );
  }

  String formatPublished(String dateTime) {
    try{
      DateTime apiDate = DateTime.parse(dateTime);
      return timeago.format(apiDate, locale: 'en');
    } catch (e) {
      return '';
    }
  }

  Future showBottomSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(
            left: width * 0.03,
            right: width * 0.03,
            bottom: height * 0.02,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.symmetric(horizontal: width*.022,vertical: height*.01),
          child: Column(
            spacing: height*.015,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: widget.articles.urlToImage ?? '',
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator(color: ColorApp.grayColor)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              buildDescription(widget.articles.description ?? ''),
              ElevatedButton(
                onPressed: openArticle,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: height * .018),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  minimumSize: Size(double.infinity, height * .01),
                  elevation: 0,
                ),
                child: Text(
                  'View Full Article',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDescription (String desc){
    const maxLength = 250;
    if(desc.length <= maxLength){
      return Text(desc);
    }
    final remaining = desc.length - maxLength;
    final shortDesc = desc.substring(0, maxLength);
    return RichText(text: TextSpan(
      style: Theme.of(context).textTheme.bodyMedium,
      children: [
        TextSpan(text: '$shortDesc...'),
        TextSpan(text: '[+$remaining chars]'),
      ]
    ));
  }

  void openArticle() async {
    final url = widget.articles.url;
    if (url == null || url.isEmpty) return;

    final fixedUrl = url.startsWith('http') ? url : 'https://$url';
    final Uri uri = Uri.parse(fixedUrl);

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        debugPrint("Could not launch $fixedUrl");
      }
    } catch (e) {
      debugPrint("Error launching URL: $e");
    }
  }
}
