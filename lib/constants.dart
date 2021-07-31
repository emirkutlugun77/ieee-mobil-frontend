import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData whiteTheme = ThemeData(
    primaryColor: Color(0xFF376AED),
    primaryColorDark: Color(0xFF2151CD),
    primaryColorLight: Color(0xFF386BED),
    cardColor: Color(0xFF0D253C),
    bottomAppBarColor: Color(0xFF7B8BB2),
    accentColor: Color(0xFF8FE6FF),
    splashColor: Color(0xFF127C12),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.inter(
          fontSize: 14, color: Color(0xFF0D253C), fontWeight: FontWeight.w400),
      bodyText2: GoogleFonts.inter(
          fontSize: 16, color: Color(0xFF0D253C), fontWeight: FontWeight.w600),
      headline1: GoogleFonts.inter(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0D253C),
      ),
      headline2: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xFF0D253C),
      ),
      headline3: GoogleFonts.inter(
        fontSize: 19,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headline4: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      subtitle1: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: Color(0xFF2D4379),
      ),
      subtitle2: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF2D4379),
      ),
    ));
