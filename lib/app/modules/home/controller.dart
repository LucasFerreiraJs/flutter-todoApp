import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todoapp/app/data/models/task.dart';
import 'package:todoapp/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  //make it observable
  final tasks = <Task>[].obs;
  final editController = TextEditingController();
  final chipIndex = 0.obs;

  void changeChipIndex(int index) {
    chipIndex.value = index;
  }

  bool addTask(Task newTask) {
    if (tasks.contains(newTask)) {
      return false;
    }
    tasks.add(newTask);
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());

    // change
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    print("close");
    super.onClose();
  }
}
