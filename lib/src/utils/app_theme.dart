import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData themeData = ThemeData(
  textTheme: GoogleFonts.robotoTextTheme(
    const TextTheme(
      bodyText2: TextStyle(color: Colors.black),
    ),
  ),
  scaffoldBackgroundColor: Colors.transparent,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
