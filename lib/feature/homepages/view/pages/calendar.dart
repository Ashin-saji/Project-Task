import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../control/task_provider.dart';
import '../../model/task.dart';

class SchedulePage extends ConsumerStatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskListProvider);
    
    
    final selectedDateTasks = tasks.where((task) =>
      task.dueDate.year == _selectedDate.year &&
      task.dueDate.month == _selectedDate.month &&
      task.dueDate.day == _selectedDate.day
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        backgroundColor: Color.fromARGB(255, 106, 81, 206),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(Duration(days: 365)),
            lastDay: DateTime.now().add(Duration(days: 365)),
            focusedDay: _focusedDate,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDate = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 106, 81, 206),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 106, 81, 206).withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tasks for ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => _showAddTaskDialog(context),
                        color: Color.fromARGB(255, 106, 81, 206),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: selectedDateTasks.isEmpty
                      ? Center(
                          child: Text(
                            'No tasks for this date',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: selectedDateTasks.length,
                          itemBuilder: (context, index) {
                            final task = selectedDateTasks[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: ListTile(
                                title: Text(task.title),
                                subtitle: Text(task.description),
                                trailing: Checkbox(
                                  value: task.isCompleted,
                                  onChanged: (_) {
                                    ref.read(taskListProvider.notifier)
                                        .toggleTaskCompletion(task.id);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Task for ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 106, 81, 206),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  final task = Task(
                    id: DateTime.now().toString(),
                    title: titleController.text,
                    description: descriptionController.text,
                    dueDate: _selectedDate,
                  );
                  ref.read(taskListProvider.notifier).addTask(task);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Task added for selected date')),
                  );
                }
              },
              child: Text(
                'Add Task',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}