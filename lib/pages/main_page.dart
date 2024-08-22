import 'package:flutter/material.dart';
import '../screens/profile.dart';
import '../theme/theme.dart';
import '../screens/all_tasks.dart'; // Импортируем TaskPage

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    TaskPage(), // Добавляем TaskPage в список экранов
    const Center(child: Text('Сегодня')),
    ProfilePage(), // Заменяем Center на ProfilePage
    const Center(child: Text('Выполнено')),
  ];

  // Функция для показа диалогового окна
  void _showAddTaskDialog() {
    // Создаем контроллеры для полей ввода
    final _nameController = TextEditingController();
    final _descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog( // Используем Dialog вместо AlertDialog
          child: Container(
            width: 500, // Устанавливаем ширину диалогового окна
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: 'Название задачи'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(hintText: 'Описание'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Обработка данных задачи
                    // ...
                    Navigator.of(context).pop(); // Закрытие диалогового окна
                  },
                  child: const Text('Добавить'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Прозрачный AppBar
        elevation: 0, // Убираем тень
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, // Направление распространения градиента
            end: Alignment.bottomCenter,
            colors: [
              DoDidDoneTheme.lightTheme.colorScheme.secondary,
              DoDidDoneTheme.lightTheme.colorScheme.primary,
            ],
            stops: const [0.1, 0.9], // Основной цвет занимает 90%
          ),
        ),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent, // Прозрачный BottomNavigationBar
        elevation: 0, // Убираем тень
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: 'Задачи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Сегодня',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Выполнено',
          ),
        ],
      ),
      // Условие для показа FloatingActionButton
      floatingActionButton: _selectedIndex == 0 
          ? FloatingActionButton(
              onPressed: _showAddTaskDialog,
              child: const Icon(Icons.add),
            ) 
          : null,
    );
  }
}
