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
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Color.fromARGB(221, 21, 16, 16)),
        backgroundColor: colorScheme.secondaryContainer,
        foregroundColor: colorScheme.onSecondaryContainer,
      ),
      textTheme: GoogleFonts.latoTextTheme(),
      useMaterial3: true,
      colorScheme: colorScheme,
      timePickerTheme: const TimePickerThemeData().copyWith(
        hourMinuteTextStyle: const TextStyle(fontSize: 45),
        helpTextStyle: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
