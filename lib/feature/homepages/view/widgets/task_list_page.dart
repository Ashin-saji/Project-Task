import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../control/task_provider.dart';
import '../../model/task.dart';

class TaskListPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends ConsumerState<TaskListPage> {
  String searchQuery = ""; 
  bool isAscending = true; 

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskListProvider);

    
    final filteredTasks = tasks
        .where((task) => task.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    
    filteredTasks.sort((a, b) =>
        isAscending ? a.dueDate.compareTo(b.dueDate) : b.dueDate.compareTo(a.dueDate));

    final today = DateTime.now();
    final tomorrow = today.add(Duration(days: 1));
    final weekEnd = today.add(Duration(days: 7));

    final todayTasks = filteredTasks.where((task) =>
        task.dueDate.year == today.year &&
        task.dueDate.month == today.month &&
        task.dueDate.day == today.day).toList();

    final tomorrowTasks = filteredTasks.where((task) =>
        task.dueDate.year == tomorrow.year &&
        task.dueDate.month == tomorrow.month &&
        task.dueDate.day == tomorrow.day).toList();

    final thisWeekTasks = filteredTasks.where((task) =>
        task.dueDate.isAfter(tomorrow) && task.dueDate.isBefore(weekEnd)).toList();

    String formattedDate = DateFormat('EEEE, d MMM').format(today);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ HEADER CONTAINER WITH SEARCH & SORT FUNCTIONALITY
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 174, 102, 234),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 40),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Search Tasks",
                          hintStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value; 
                          });
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isAscending = !isAscending; 
                        });
                      },
                      icon: Icon(
                        isAscending ? Icons.sort : Icons.south_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  formattedDate,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 5),
                const Text(
                  "My Tasks",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ],
            ),
          ),

     
          Expanded(
            child: ListView(
              children: [
                if (todayTasks.isNotEmpty) _buildTaskSection('Today', todayTasks, ref),
                if (tomorrowTasks.isNotEmpty) _buildTaskSection('Tomorrow', tomorrowTasks, ref),
                if (thisWeekTasks.isNotEmpty) _buildTaskSection('This Week', thisWeekTasks, ref),
                if (filteredTasks.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(child: Text("No tasks found", style: TextStyle(fontSize: 16))),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskSection(String title, List<Task> tasks, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) {
                      ref.read(taskListProvider.notifier).toggleTaskCompletion(task.id);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      ref.read(taskListProvider.notifier).removeTask(task.id);
                    },
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, '/schedule', arguments: task);
              },
            );
          },
        ),
      ],
    );
  }
}
