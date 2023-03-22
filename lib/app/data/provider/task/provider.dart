import 'dart:convert';

import 'package:get/get.dart';
import 'package:todoapp/app/core/utils/keys.dart';
import 'package:todoapp/app/data/models/task.dart';
import 'package:todoapp/app/data/services/storage/services.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  // traz a lista
  List<Task> readTasks() {
    var tasks = <Task>[];

    jsonDecode(_storage.read(taskKey).toString()).forEach((item) => {
          tasks.add(Task.fromJson(item)),
        });

    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
