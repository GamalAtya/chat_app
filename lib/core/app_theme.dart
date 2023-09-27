import 'package:flutter/material.dart';
import 'colors/colors.dart';



final appTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
    ),
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    // primaryColorDark: AppColors.darkBackgroundColor,
    // highlightColor: AppColors.lightWhite,
    // disabledColor: AppColors.grey,
    // canvasColor: AppColors.white,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: AppColors.primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: AppColors.primaryColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(8),
        )));
