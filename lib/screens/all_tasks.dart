import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Импортируем пакет intl

import '../widgets/task_item.dart';
import '../theme/theme.dart'; // Импортируем DoDidDoneTheme

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Купить продукты',
      'description': 'Молоко, хлеб, яйца',
      'deadline': DateTime.now().add(const Duration(days: 2)),
    },
    {
      'title': 'Позвонить другу',
      'description': 'Обсудить планы на выходные',
      'deadline': DateTime.now().add(const Duration(days: 1)),
    },
    {
      'title': 'Сделать домашнее задание',
      'description': 'Математика, физика',
      'deadline': DateTime.now().add(const Duration(days: 3)),
    },
    {
      'title': 'Записаться на тренировку',
      'description': 'Йога в 18:00',
      'deadline': DateTime.now().add(const Duration(days: 5)),
    },
    {
      'title': 'Проверить почту',
      'description': 'Проверить важные письма',
      'deadline': DateTime.now().add(const Duration(days: 1)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container( // Используем Container вместо Scaffold
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, // Направление распространения градиента
          end: Alignment.bottomCenter,
          colors: [
            DoDidDoneTheme.lightTheme.colorScheme.secondary, // Добавляем вторичный цвет
            DoDidDoneTheme.lightTheme.colorScheme.primary, // Добавляем основной цвет
          ],
          stops: const [0.1, 0.9], // Основной цвет занимает 90%
        ),
      ),
      child: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return TaskItem(
            title: _tasks[index]['title'],
            description: _tasks[index]['description'],
            deadline: _tasks[index]['deadline'], // Передаем DateTime объект
          );
        },
      ),
    );
  }
}
