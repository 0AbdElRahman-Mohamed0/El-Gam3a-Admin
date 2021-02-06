import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFF0D5C75),
    buttonColor: Color(0xFF199FB1),
    errorColor: Color(0xFFFF5858),
    accentColor: Color(0xFFA5D1E1),
    focusColor: Color(0xFF199FB1),
    dividerColor: Color(0xFF9A9B9B),
    cardColor: Color(0xFFF2F2F2),
    shadowColor: Color(0xFF000000).withOpacity(0.1),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 17.6,
      ),
      hintStyle: TextStyle(
        fontFamily: 'Calibri',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF707070),
      ),
      isDense: true,
      filled: true,
      fillColor: Color(0xFFF2F2F2),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
    ),
    textTheme: TextTheme(
      // title
      headline6: TextStyle(
        fontFamily: 'Calibri',
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: Color(0xFF199FB1),
      ),
      ////

      headline1: TextStyle(
        fontFamily: 'Calibri',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF199FB1),
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
