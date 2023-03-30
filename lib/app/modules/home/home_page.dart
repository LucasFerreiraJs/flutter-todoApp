import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/app/core/values/colors.dart';
import 'package:todoapp/app/data/models/task.dart';
import 'package:todoapp/app/modules/home/home_controller.dart';
import 'package:todoapp/app/core/utils/extensions.dart';
import 'package:todoapp/app/modules/home/widgets/addcard_widget.dart';
import 'package:todoapp/app/modules/home/widgets/addcard_widget.dart';
import 'package:todoapp/app/modules/home/widgets/addtask_dialog_widget.dart';
import 'package:todoapp/app/modules/home/widgets/taskcard_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                "My List",
                style: TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() => GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: <Widget>[
                    // TaskCardWidget(task: Task(title: "Tarefa 01", icon: 0xe59c, color: '#41cf9f')),
                    ...controller.taskList
                        .map((item) => LongPressDraggable(
                              data: item,
                              onDragStarted: () => controller.changeDeleting(true), // * homeController
                              onDraggableCanceled: (_, __) => controller.changeDeleting(false),
                              onDragEnd: (_) => controller.changeDeleting(false),
                              feedback: Opacity(
                                opacity: 0.8,
                                child: TaskCardWidget(task: item),
                              ),
                              child: TaskCardWidget(task: item),
                            ))
                        .toList(),
                    AddCardWidget(),
                  ],
                ))
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) => Obx(
          () => FloatingActionButton(
            onPressed: () {
              print("float press");

              Get.to(() => AddTaskDialogWidget(), transition: Transition.downToUp);
            },
            backgroundColor: controller.deleting.value ? Colors.red[400]! : blue,
            child: Icon(
              controller.deleting.value ? Icons.delete : Icons.add,
            ),
          ),
        ),
        onAccept: (Task task) {
          print(task);

          controller.deleteTask(task);
          EasyLoading.showSuccess('${task.title} deleted');
        },
      ),
    );
  }
}
