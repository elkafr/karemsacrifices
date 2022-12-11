import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karemsacrifices/utils/app_colors.dart';


ThemeData themeData() {
  return ThemeData(
    accentColor: cAccentColor,
      primaryColor: cPrimaryColor,
      hintColor: cHintColor,
      brightness: Brightness.light,
      buttonColor: cPrimaryColor,
      scaffoldBackgroundColor: Color(0xffFFFFFF),
      fontFamily: 'HelveticaNeueW23forSKY',
      cursorColor: cPrimaryColor,
      textTheme: TextTheme(
        // app bar style
        display1:
            TextStyle(color: cWhite, fontSize: 17, fontWeight: FontWeight.w400,),

        // title of dialog
        title: TextStyle(
            fontFamily: 'HelveticaNeueW23forSKY',
            fontSize: 18,
            fontWeight: FontWeight.w400),


//  Style text on button
        button: TextStyle(
            fontFamily: 'HelveticaNeueW23forSKY',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16.0),

      ));
}

