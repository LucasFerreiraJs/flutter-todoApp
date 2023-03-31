import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todoapp/app/data/models/task.dart';
import 'package:todoapp/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  //make it observable
  final taskList = <Task>[].obs;
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final taskSelected = Rx<Task?>(null);

  void changeChipIndex(int index) {
    chipIndex.value = index;
  }

  bool addTask(Task newTask) {
    if (taskList.contains(newTask)) {
      return false;
    }
    taskList.add(newTask);
    return true;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void deleteTask(Task task) {
    taskList.remove(task);
  }

  void changeTask(Task? select) {
    taskSelected.value = select;
  }

  bool updateTask(Task task, String title) {
    var todos = task.todos ?? [];

    if (containTodo(todos, title)) {
      return false;
    }

    var todo = {'title': title, 'done': false};
    todos.add(todo);

    Task newTask = task.copyWith(todos: todos);
    int oldTaskIndex = taskList.indexOf(task);
    taskList[oldTaskIndex] = newTask;
    taskList.refresh();
    return true;
  }

  bool containTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }

  @override
  void onInit() {
    super.onInit();
    taskList.assignAll(taskRepository.readTasks());

    // change
    ever(taskList, (_) => taskRepository.writeTasks(taskList));
  }

  @override
  void onClose() {
    print("close");
    editController.dispose();
    super.onClose();
  }
}
