import 'package:appsize/appsize.dart';
import 'package:flutter/material.dart';

class MovieTheme {
  static ThemeData get darkTheme => ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade700,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,
          elevation: 3,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.grey.shade700,
          elevation: 3,
        ),
        cardColor: Colors.grey.shade700,
        textTheme: TextTheme(
          /// Make all the styles have a white color
          bodyText1: const TextStyle(color: Colors.white),
          bodyText2: const TextStyle(color: Colors.white),
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 16.sp,
          ),
          headline3: const TextStyle(color: Colors.white),
          headline4: const TextStyle(color: Colors.white),
          headline5: const TextStyle(color: Colors.white),
          headline6: const TextStyle(color: Colors.white),
          subtitle1: const TextStyle(color: Colors.white),
          subtitle2: const TextStyle(color: Colors.white),
          caption: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
          button: const TextStyle(color: Colors.white),
          overline: const TextStyle(color: Colors.white),
        ),
        primaryColor: Colors.black,
      );

  static ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          elevation: 3,
        ),
        cardColor: Colors.white,
        textTheme: TextTheme(
          /// Make all the styles have a white color
          bodyText1: const TextStyle(color: Colors.black),
          bodyText2: const TextStyle(color: Colors.black),
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 16.sp,
          ),
          headline3: const TextStyle(color: Colors.black),
          headline4: const TextStyle(color: Colors.black),
          headline5: const TextStyle(color: Colors.black),
          headline6: const TextStyle(color: Colors.black),
          subtitle1: const TextStyle(color: Colors.black),
          subtitle2: const TextStyle(color: Colors.black),
          caption: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
          button: const TextStyle(color: Colors.black),
          overline: const TextStyle(color: Colors.black),
        ),
        primaryColor: Colors.grey.shade100,
      );
}
