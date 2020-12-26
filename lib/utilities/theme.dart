import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFF425B53),
    buttonColor: Color(0xFFED9539),
    errorColor: Color(0xFFFF5858),
    accentColor: Color(0xFFDD7215),
    focusColor: Color(0xFF6D8F8E),
    dividerColor: Color(0xFF9A9B9B),
    cardColor: Color(0xFFF2F2F2),
    shadowColor: Color(0xFF000000).withOpacity(0.1),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF155E9F),
      selectedLabelStyle: TextStyle(
        fontSize: 10,
        // fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
      ),
      selectedIconTheme: IconThemeData(size: 24.0),
//      selectedItemColor: Colors.white,
      unselectedLabelStyle: TextStyle(
        fontSize: 10,
        // fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
      ),
      unselectedIconTheme: IconThemeData(size: 24.0),
      unselectedItemColor: Color(0x80FFFFFF),
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: TextTheme(
      // title
      headline6: TextStyle(
        fontFamily: 'Calibri',
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: Color(0xFF425B53),
      ),
      ////

      headline1: TextStyle(
        fontFamily: 'Calibri',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF425B53),
      ),

      headline2: TextStyle(
        fontFamily: 'Calibri',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF707070),
      ),

      headline3: TextStyle(
        fontFamily: 'Calibri',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Color(0xFFF9F9F9),
      ),

      headline4: TextStyle(
        fontFamily: 'Calibri',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFFF9F9F9),
      ),

      headline5: TextStyle(
        fontFamily: 'Calibri',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF707070),
      ),
    ),
  );
}
