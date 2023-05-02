import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const brightness = Brightness.light;

ThemeData androidTheme() {
  return ThemeData(
    brightness: brightness,
    textTheme: TextTheme(
      headline1: GoogleFonts.quicksand(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Colors.white,
      ),
      headline2: GoogleFonts.quicksand(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.white,
      ),
      subtitle1: GoogleFonts.quicksand(
        fontSize: 16,
        color: Colors.white,
      ),
      
    ),
    primaryColor: Colors.white,
    backgroundColor: const Color.fromARGB(255, 36, 36, 36),
  );
}
