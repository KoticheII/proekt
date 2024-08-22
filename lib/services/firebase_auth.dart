import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Объект для работы с Firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Объект для работы с Google Sign-In
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Получение текущего пользователя
  User? get currentUser => _auth.currentUser;

  // Регистрация с помощью электронной почты и пароля
  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      // Регистрация пользователя
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Отправка запроса на подтверждение почты
      await userCredential.user!.sendEmailVerification();

      // Вывод сообщения о необходимости подтверждения почты
      print('Пожалуйста, подтвердите свой адрес электронной почты.');
    } catch (e) {
      // Обработка ошибок
      print('Ошибка регистрации: ${e.toString()}');
      rethrow;
    }
  }

  // Вход с помощью электронной почты и пароля
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // Вход пользователя
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      // Обработка ошибок
      print('Ошибка входа: ${e.toString()}');
      rethrow;
    }
  }

  // Выход из системы
  Future<void> signOut() async {
    try {
      // Выход из Firebase
      await _auth.signOut();

      // Выход из Google
      await _googleSignIn.signOut();
    } catch (e) {
      // Обработка ошибок
      print('Ошибка выхода: ${e.toString()}');
      rethrow;
    }
  }
}
