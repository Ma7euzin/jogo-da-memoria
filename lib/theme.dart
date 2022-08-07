import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NarutoTheme {
  static const MaterialColor color = MaterialColor(
    _narutoPrimaryValue,
    <int, Color>{
      50: Color(0xFFFFFDE7),
      100: Color(0xFFFFF9C4),
      200: Color(0xFFFFF59D),
      300: Color(0xFFFFF176),
      400: Color(0xFFFFEE58),
      500: Color(_narutoPrimaryValue),
      600: Color(0xFFFDD835),
      700: Color(0xFFFBC02D),
      800: Color(0xFFF9A825),
      900: Color(0xFFF57F17),
    },
  );

  static const int _narutoPrimaryValue = 0xFFFF0000;

  static const Color background = Color(0XFF121212);

  static ButtonStyle outlineButtonStyle({
    Color color = Colors.white,
    double padding = 24,
  }) {
    return OutlinedButton.styleFrom(
      primary: color,
      padding: EdgeInsets.symmetric(vertical: padding),
      side: BorderSide(color: color),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    );
  }

  static ThemeData theme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primarySwatch: color,
      primaryColor: color,
      textTheme: GoogleFonts.wendyOneTextTheme(
        ThemeData.dark().textTheme,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: outlineButtonStyle(),
      ),
      appBarTheme: ThemeData.dark().appBarTheme.copyWith(
            elevation: 0,
            backgroundColor: Colors.transparent,
            titleTextStyle: GoogleFonts.wendyOne(fontSize: 25),
            centerTitle: true,
          ));
}
