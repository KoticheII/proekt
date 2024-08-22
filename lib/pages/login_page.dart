import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'main_page.dart';
import '../services/firebase_auth.dart'; // Импортируем AuthenticationService

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true; // Флаг для определения режима (вход/регистрация)
  final _formKey = GlobalKey<FormState>(); // Ключ для формы
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController(); // Контроллер для поля подтверждения пароля
  final _authService = AuthService(); // Создаем экземпляр AuthenticationService

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose(); // Освобождаем контроллер
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: isLogin
                ? [
                    DoDidDoneTheme.lightTheme.colorScheme.secondary,
                    DoDidDoneTheme.lightTheme.colorScheme.primary,
                  ]
                : [
                    DoDidDoneTheme.lightTheme.colorScheme.primary,
                    DoDidDoneTheme.lightTheme.colorScheme.secondary,
                  ],
            stops: const [0.1, 0.9],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey, // Добавляем ключ для формы
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ... (Название приложения, заголовок)

                // Поле логина/почты
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Почта',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите почту';
                    }
                    if (!value.contains('@')) {
                      return 'Некорректный формат почты';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Поле пароля
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Пароль',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите пароль';
                    }
                    if (value.length < 6) {
                      return 'Пароль должен быть не менее 6 символов';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // **Поле для повтора пароля**
                if (!isLogin) // Показываем только при регистрации
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Повторить пароль',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, повторите пароль';
                      }
                      if (value != _passwordController.text) {
                        return 'Пароли не совпадают';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 30),

                // Кнопка "Войти"
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Проверяем, валидна ли форма
                      if (isLogin) {
                        // Вход
                        try {
                          await _authService.signInWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                          // Переход на MainPage
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()));
                        } catch (e) {
                          // Обработка ошибок входа
                          print('Ошибка входа: ${e.toString()}');
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Ошибка входа: ${e.toString()}')));
                        }
                      } else {
                        // Регистрация
                        try {
                          await _authService.registerWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                          // После успешной регистрации переходим на страницу подтверждения почты
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()));
                        } catch (e) {
                          // Обработка ошибок регистрации
                          print('Ошибка регистрации: ${e.toString()}');
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Ошибка регистрации: ${e.toString()}')));
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !isLogin
                        ? DoDidDoneTheme.lightTheme.colorScheme.primary
                        : DoDidDoneTheme.lightTheme.colorScheme.secondary,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(isLogin ? 'Войти' : 'Зарегистрироваться'),
                ),
                const SizedBox(height: 20),

                // Кнопка перехода на другую страницу
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(
                    isLogin
                        ? 'У меня еще нет аккаунта...'
                        : 'Уже есть аккаунт...',
                    style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
