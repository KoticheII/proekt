import 'package:flutter/material.dart';

class DoDidDoneTheme {
  static ThemeData lightTheme = ThemeData(
    // Define your primary and secondary colors
    primaryColor: const Color(0xFF9F7BF4), // #9F7BF4
    secondaryHeaderColor: const Color(0xFF4CEF8A), // #4CEF8A

    // You can customize other theme properties as needed
    // ...

    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );
}
