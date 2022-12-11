
import 'package:flutter/material.dart';
import 'package:karemsacrifices/utils/app_colors.dart';

class HorizontalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
      return Container(
   margin: EdgeInsets.only(top: constraints.maxHeight *0.01),
          height: 1,
          color: cDarkGrey.withOpacity(0.10)
        );
      }
    );
  }
}