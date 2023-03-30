
import 'package:get/get.dart';
import 'package:todoapp/app/data/provider/task/provider.dart';
import 'package:todoapp/app/data/services/storage/repository.dart';
import 'package:todoapp/app/modules/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
