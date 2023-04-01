import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/app/core/utils/extensions.dart';
import 'package:todoapp/app/modules/home/home_controller.dart';

class DoingListWidget extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DoingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.doingTodos.isEmpty && homeController.doneTodos.isEmpty
          ? Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/task.png',
                  fit: BoxFit.cover,
                  width: 65.0.wp,
                ),
                Text(
                  "Add Task",
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeController.doingTodos
                    .map(
                      (item) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9.0.wp, vertical: 3.0.wp),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                fillColor: MaterialStateColor.resolveWith((states) => Colors.grey),
                                value: item['done'],
                                onChanged: (value) {
                                  homeController.setDoneTodo(item['title']);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                              child: Text(
                                item['title'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
                if (homeController.doneTodos.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: const Divider(
                      thickness: 2,
                    ),
                  )
              ],
            ),
    );
  }
}
