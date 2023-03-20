import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor:Colortheme1.dark_blue(),
    scaffoldBackgroundColor: Colortheme1.light_blue(),
    colorScheme:
        ColorScheme.light().copyWith(primary: Colortheme1.dark_blue()),
     bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colortheme1.dark_blue(),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      selectedLabelStyle: TextStyle(color: Colors.white,fontSize: 12),
      //unselectedLabelStyle: TextStyle(color: Colors.white),
      showSelectedLabels: true,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.kanit(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headline2: GoogleFonts.kanit(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: GoogleFonts.kanit(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
