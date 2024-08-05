import 'package:flutter/material.dart';
import 'package:proekt/theme/theme.dart'; // Импорт темы приложения

import 'main_page.dart'; // Импорт главной страницы

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true; // Флаг, отслеживающий, находится ли пользователь в режиме входа или регистрации

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              DoDidDoneTheme.lightTheme.colorScheme.secondary, // Вторичный цвет
              DoDidDoneTheme.lightTheme.colorScheme.primary, // Основной цвет
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Расположение текста. В данном случае по центру экрана
            children: [
              // Заголовок
              Text(
                isLogin ? 'Вход' : 'Регистрация', // Заголовок меняется в зависимости от режима
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),

              // Поле ввода электронной почты
              TextField(
                decoration: InputDecoration(
                  hintText: 'Логин', // Подсказка для поля ввода
                  hintStyle: const TextStyle(color: Colors.white), // Стиль подсказки
                  filled: true, // Заполнить поле цветом
                  fillColor: Colors.white.withOpacity(0.2), // Цвет заполнения
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25), // Закругленные углы поля
                    borderSide: BorderSide.none, // Убрать границу поля
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Поле ввода пароля
              TextField(
                obscureText: true, // Скрыть текст пароля
                decoration: InputDecoration(
                  hintText: 'Пароль', // Подсказка для поля ввода
                  hintStyle: const TextStyle(color: Colors.white), // Стиль подсказки
                  filled: true, // Заполнить поле цветом
                  fillColor: Colors.white.withOpacity(0.2), // Цвет заполнения
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25), // Закругленные углы поля
                    borderSide: BorderSide.none, // Убрать границу поля
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Поле ввода пароля для подтверждения (только для регистрации)
              if (!isLogin)
                TextField(
                  obscureText: true, // Скрыть текст пароля
                  decoration: InputDecoration(
                    hintText: 'Повторить пароль', // Подсказка для поля ввода
                    hintStyle: const TextStyle(color: Colors.white), // Стиль подсказки
                    filled: true, // Заполнить поле цветом
                    fillColor: Colors.white.withOpacity(0.2), // Цвет заполнения
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25), // Закругленные углы поля
                      borderSide: BorderSide.none, // Убрать границу поля
                    ),
                  ),
                ),
              const SizedBox(height: 10),

              // Кнопка входа/регистрации
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,             //Переход со страницы "Логин" на главную страницу
                      MaterialPageRoute(builder: (context) => const MainPage())); 
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Цвет фона кнопки
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Отступы внутри кнопки
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Стиль текста кнопки
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // Закругленные углы кнопки
                  ),
                ),
                child: Text(isLogin ? 'Войти' : 'Зарегистрироваться'), // Текст кнопки меняется в зависимости от режима
              ),
              const SizedBox(height: 10),

              // Переключение между режимами входа и регистрации
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin; // Изменить режим на противоположный
                  });
                },
                child: Text(
                  isLogin ? 'У меня еще нет аккаунта' : 'Уже есть аккаунт', // Текст кнопки меняется в зависимости от режима
                  style: const TextStyle(color: Colors.white), // Стиль текста кнопки
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
