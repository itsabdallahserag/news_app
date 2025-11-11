import 'package:flutter/material.dart';
import 'package:news_api_app/Category/category_details_view_model.dart';
import 'package:news_api_app/Category/category_fragment/category.dart';
import 'package:news_api_app/Category/widget/source_tapBar_widget.dart';
import 'package:news_api_app/api/api_manager.dart';
import 'package:news_api_app/model/source_response.dart';
import 'package:news_api_app/utils/color_app.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key,required this.category});
  final Category category;
  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}
class _CategoryDetailsState extends State<CategoryDetails> {
  CategoryDetailsViewModel viewModel = CategoryDetailsViewModel() ;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    viewModel.getSources(widget.category.id);
  }
  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child:
      Consumer<CategoryDetailsViewModel>(
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
                      viewModel.getSources(widget.category.id);
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
            }if(viewModel.sourcesList == null) {
              return Center(
               child: CircularProgressIndicator(color: ColorApp.grayColor),
             );
            }else{
              return SourceTapBarWidget(sourcesList: viewModel.sourcesList!);
            }
          },
      )
    );
  }
}
//FutureBuilder<Source>(
//         future: ApiManager.getSources(categoryId: widget.category.id,),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(color: ColorApp.grayColor),
//             );
//           } else if (snapshot.hasError) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Something went wrong',
//                   style: Theme.of(context).textTheme.labelLarge,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     ApiManager.getSources(categoryId: widget.category.id);
//                     setState(() {});
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: ColorApp.grayColor,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: width * .01,
//                       vertical: height * .001,
//                     ),
//                   ),
//                   child: Text('Try Again', style: text.displayMedium),
//                 ),
//               ],
//             );
//           } else if (snapshot.hasData && snapshot.data?.status != 'ok') {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   snapshot.data?.message ?? 'Error occurred',
//                   style: Theme.of(context).textTheme.labelLarge,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     ApiManager.getSources(categoryId: widget.category.id);
//                     setState(() {});
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).dividerColor,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: width * .01,
//                       vertical: height * .001,
//                     ),
//                   ),
//                   child: Text('Try Again', style: text.displayMedium),
//                 ),
//               ],
//             );
//           }
//           var sourcesList = snapshot.data?.sources ?? [];
//           return SourceTapBarWidget(sourcesList: sourcesList);
//         },
//       ),