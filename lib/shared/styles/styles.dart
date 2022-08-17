import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData lightMode = ThemeData(
  textTheme: TextTheme(
    bodyText2: TextStyle(
        fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
    bodyText1: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
  ),
  primarySwatch: defaultColor,

  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      iconTheme: IconThemeData(color: Colors.black, size: 30.0),
      elevation: 0.0,
      backgroundColor: Colors.white,

      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
    selectedItemColor:defaultColor,
  ),
);

ThemeData darkMode = ThemeData(
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
    bodyText2: TextStyle(
        fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white),
  ),
  primarySwatch: defaultColor,

  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      iconTheme: IconThemeData(color: Colors.grey, size: 30.0),
      elevation: 0.0,
      backgroundColor: HexColor('333739'),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light),
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.grey)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
    selectedItemColor: defaultColor,
  ),
);
