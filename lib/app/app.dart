import 'package:flutter/material.dart';
import 'package:proekt/pages/lodin_page.dart';
import 'package:proekt/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: DoDidDoneTheme.lightTheme,
      home: const LoginPage(),
    );
  }
}
