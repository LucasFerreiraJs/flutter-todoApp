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
