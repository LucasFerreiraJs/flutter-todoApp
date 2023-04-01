import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todoapp/app/core/utils/extensions.dart';
import 'package:todoapp/app/data/models/task.dart';
import 'package:todoapp/app/modules/details/detail_page.dart';
import 'package:todoapp/app/modules/home/home_controller.dart';

class TaskCardWidget extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final Task task;
  TaskCardWidget({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    final squareWidth = Get.width - 12.0.wp;

    return GestureDetector(
      onTap: () {
        homeController.changeTask(task);
        homeController.changeTodos(task.todos ?? []);

        Get.to(DetailPage(), transition: Transition.rightToLeft);
      },
      child: Container(
          width: squareWidth / 2,
          height: squareWidth / 2,
          margin: EdgeInsets.all(3.0.wp),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 7,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StepProgressIndicator(
                  totalSteps: 100,
                  currentStep: 80,
                  size: 5,
                  padding: 0,
                  selectedGradientColor: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color.withOpacity(0.5), color],
                  ),
                  unselectedGradientColor: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.white],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0.wp),
                  child: Icon(
                    IconData(
                      task.icon,
                      fontFamily: "MaterialIcons",
                    ),
                    color: color,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0.wp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        task.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.0.wp),
                      Text(
                        '${task.todos?.length ?? 0} Tasks',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
