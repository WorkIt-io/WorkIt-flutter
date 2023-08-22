import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ColorScheme colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(212, 255, 168, 36),
  brightness: Brightness.light,
  background: Colors.grey[400],
);

class CurrentTheme {
  ThemeData get themeData {
    return ThemeData().copyWith(      
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: colorScheme.secondaryContainer,
        foregroundColor: colorScheme.onSecondaryContainer,         
      ),
      textTheme: GoogleFonts.latoTextTheme(),
      useMaterial3: true,
      colorScheme: colorScheme,            
    );
  }
}
