import 'package:todoapp/app/data/models/task.dart';
import 'package:todoapp/app/data/provider/task/provider.dart';

class TaskRepository {
  TaskProvider taskProvider;

  TaskRepository({required this.taskProvider});

  @override
  List<Task> readTasks() => taskProvider.readTasks();

  @override
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
