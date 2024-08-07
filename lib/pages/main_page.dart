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
    final _deadlineController = TextEditingController();
    DateTime? _selectedDateTime; // Переменная для хранения выбранной даты и времени

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
                const SizedBox(height: 16),
                // Используем InkWell для выбора даты и времени
                InkWell(
                  onTap: () async {
                    // Открываем диалог выбора даты и времени
                    _selectedDateTime = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (_selectedDateTime != null) {
                      // Если дата выбрана, открываем диалог выбора времени
                      TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedTime != null) {
                        // Соединяем выбранную дату и время
                        _selectedDateTime = DateTime(
                          _selectedDateTime!.year,
                          _selectedDateTime!.month,
                          _selectedDateTime!.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                        // Обновляем контроллер для отображения выбранной даты и времени
                        _deadlineController.text =
                            _selectedDateTime!.toString();
                      }
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(hintText: 'Дедлайн'),
                    child: Text(_deadlineController.text.isEmpty
                        ? 'Выберите дату и время'
                        : _deadlineController.text),
                  ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog, // Вызываем диалоговое окно при нажатии
        child: const Icon(Icons.add),
      ),
    );
  }
}
