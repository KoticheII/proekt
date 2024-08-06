import 'package:flutter/material.dart';

class DoDidDoneTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF9f7bf6), // Основной цвет
      brightness: Brightness.light,
      primary: const Color(0xFF9F7BF6),  // Основной цвет
      secondary: const Color(0xFF4ceb8b),  // Вторичный цвет
    ),
    useMaterial3: true,
    // Добавляем стиль для кнопок
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF9F7BF6)), // Устанавливаем цвет фона кнопки
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Устанавливаем белый цвет для текста и иконок
        textStyle: MaterialStateProperty.all(
          const TextStyle(color: Colors.white), // Устанавливаем белый цвет текста в кнопке
        ),
      ),
    ),
    // Настройки цвета меню
    bottomNavigationBarTheme: BottomNavigationBarThemeData( 
      backgroundColor: Colors.transparent, // Прозрачный BottomNavigationBar
      //elevation: 0, // Убираем тень
      selectedItemColor: const Color(0xFF9F7BF6), // Основной цвет для выбранных иконок
      unselectedItemColor: Colors.grey, // Серый цвет для невыбранных иконок
    ),
  );
}
  

