import 'package:flutter/material.dart';

import '../../../../utils/color_app.dart';

class DividerItem extends StatelessWidget {
  const DividerItem({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height*.025),
      child: Divider(
        color: ColorApp.whiteColor,
        thickness: 1.5,
        endIndent: width*.02,
        indent: width*.02,
      ),
    );
  }
}
