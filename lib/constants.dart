import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Map<String, Color> blogCategoryColors = {
  'Teknoloji': Color(0xFF4565d9),
  'Kişisel Gelişim': Color(0xFFf7a950),
  'Spor': Color(0xFF27b438),
  'Eğlence': Color(0xFF811d7e),
  'Sanat/Kültür': Color(0xFF383838),
  'Kariyer': Color(0xFF0d1d96),
  'Bilim': Color(0xFF33b9db),
  'Seyahat': Color(0xFFa21a1a),
  'Kulüp Haberleri': Color(0xFF0f0f0f),
  'Röportaj': Color(0xFF73a441)
};

ThemeData whiteTheme = ThemeData(
    primaryColor: Color(0xFF376AED),
    primaryColorDark: Color(0xFF2151CD),
    primaryColorLight: Color(0xFF386BED),
    cardColor: Color(0xFF0D253C),
    bottomAppBarColor: Color(0xFF7B8BB2),
    accentColor: Color(0xFF8FE6FF),
    splashColor: Color(0xFF127C12),
    backgroundColor: Colors.white,
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
