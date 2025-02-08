import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/task.dart';

final taskListProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  
  void addTask(Task task) {
    state = [...state, task];
  }
  void toggleTaskCompletion(String taskId) {
    state = state.map((task) {
      if (task.id == taskId) {
        return Task(
          id: task.id,
          title: task.title,
          description: task.description,
          dueDate: task.dueDate,
          isCompleted: !task.isCompleted,
        );
      }
      return task;
    }).toList();
  }

 
  void removeTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }
}
