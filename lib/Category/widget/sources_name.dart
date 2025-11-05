import 'package:flutter/material.dart';
import '../../model/source_response.dart';

class SourcesName extends StatelessWidget {
  const SourcesName({super.key,required this.sources,required this.isSelected});
  final Sources sources;
  final bool isSelected ;
  @override
  Widget build(BuildContext context) {
    return Text(sources.name??'',
      style: isSelected ? Theme.of(context).textTheme.labelMedium :
          Theme.of(context).textTheme.bodySmall
    );
  }
}
