import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/app/core/values/colors.dart';
import 'package:todoapp/app/data/models/task.dart';
import 'package:todoapp/app/modules/home/home_controller.dart';
import 'package:todoapp/app/core/utils/extensions.dart';
import 'package:todoapp/app/modules/home/widgets/addcard_widget.dart';
import 'package:todoapp/app/modules/home/widgets/addcard_widget.dart';
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
                    ...controller.tasks.map((item) => TaskCardWidget(task: item)).toList(),
                    AddCardWidget(),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
