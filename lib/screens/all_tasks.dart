import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Импортируем пакет intl

import '../widgets/task_item.dart';

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
    return Scaffold( // Добавляем Scaffold для отображения страницы
      appBar: AppBar(
        title: const Text('Задачи'),
      ),
      body: ListView.builder(
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
