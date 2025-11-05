import 'package:flutter/material.dart';
import 'package:news_api_app/utils/color_app.dart';
import 'package:news_api_app/utils/text_app.dart';

class ThemeApp {
  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: ColorApp.whiteColor,
      primaryColor: ColorApp.whiteColor,
    dividerColor: ColorApp.blackColor,
      textTheme: TextTheme(
       labelLarge: TextApp.medium24Black,
        titleMedium: TextApp.medium20Black,
        labelMedium: TextApp.bold16Black,
        displayLarge: TextApp.bold24Black,
        bodySmall: TextApp.medium14Black,
        bodyMedium: TextApp.medium14White,
        displayMedium: TextApp.medium20White,
        bodyLarge: TextApp.medium24White
      )
  );
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorApp.blackColor,
    primaryColor: ColorApp.blackBgColor,
    dividerColor: ColorApp.whiteColor,
      textTheme: TextTheme(
          labelLarge: TextApp.medium24White,
          titleMedium: TextApp.medium20White,
          labelMedium: TextApp.bold16White,
          displayLarge: TextApp.bold24White,
          bodySmall: TextApp.medium14White,
          bodyMedium: TextApp.medium14Black,
          displayMedium: TextApp.medium20Black,
          bodyLarge: TextApp.medium24Black
      )
  );
}
