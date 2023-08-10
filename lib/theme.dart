import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ColorScheme colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(212, 255, 168, 36),
  brightness: Brightness.light,
);

class CurrentTheme {
  ThemeData get themeData {
    return ThemeData().copyWith(
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,        
      ),
      textTheme: GoogleFonts.latoTextTheme(),
      useMaterial3: true,
      colorScheme: colorScheme,      
    );
  }
}
