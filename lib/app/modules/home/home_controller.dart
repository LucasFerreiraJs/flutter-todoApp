import 'package:flutter/foundation.dart';
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
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

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

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();

    select.asMap().forEach((index, item) {
      var todo = select[index];
      var status = todo['done'];

      if (status == true) {
        doneTodos.add(todo);
        return;
      }

      doingTodos.add(item);
    });

    print("doingTodos ${doingTodos.length}");
    print("doneTodos ${doneTodos.length}");
  }

  // add todos
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

  bool addTodo(String title) {
    var todo = {'title': title, 'done': false};
    var doneTodo = {'title': title, 'done': false};
    if (doingTodos.any((item) => mapEquals<String, dynamic>(todo, item))) {
      return false;
    }

    if (doneTodos.any((item) => mapEquals<String, dynamic>(doneTodo, item))) {
      return false;
    }

    doingTodos.add(todo);
    return true;
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll({
      ...doingTodos,
      ...doneTodos,
    });

    var newTask = taskSelected.value!.copyWith(todos: newTodos);
    int indexTaskSelected = taskList.indexOf(taskSelected.value);
    taskList[indexTaskSelected] = newTask;
    taskSelected.refresh();
  }

  void setDoneTodo(String title) {
    var changeTodo = {'title': title, 'done': false};
    var todoIndex = doingTodos.indexWhere((item) => mapEquals<String, dynamic>(item, changeTodo));

    changeTodo['done'] = true;

    doingTodos.removeAt(todoIndex);
    doneTodos.add(changeTodo);

    doingTodos.refresh();
    doneTodos.refresh();
  }

  void deleteDoneTodo(dynamic doneTodo) {
    int index = doneTodos.indexWhere((item) => mapEquals<String, dynamic>(item, doneTodo));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodosEmpty(Task task) {
    return task.todos == null || task.todos!.isEmpty;
  }

  int getDoneTodo(Task task) {
    var res = 0;
    task.todos!.forEach((item) {
      if (item['done'] == true) {
        res += 1;
      }
    });

    return res;
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
