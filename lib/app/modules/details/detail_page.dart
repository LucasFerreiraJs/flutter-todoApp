import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todoapp/app/core/utils/extensions.dart';
import 'package:todoapp/app/modules/details/widgets/DoingList_widget.dart';
import 'package:todoapp/app/modules/home/home_controller.dart';

class DetailPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var taskSelected = homeController.taskSelected.value!;
    var color = HexColor.fromHex(taskSelected.color);

    return Scaffold(
      body: Form(
        key: homeController.formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        Get.back();
                        homeController.updateTodos();
                        homeController.changeTask(null);
                        homeController.editController.clear();
                      },
                      icon: Icon(Icons.arrow_back))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Row(children: <Widget>[
                Icon(
                  IconData(taskSelected.icon, fontFamily: "MaterialIcons"),
                  color: color,
                ),
                SizedBox(width: 3.0.wp),
                Text(
                  taskSelected.title,
                  style: TextStyle(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ),
            Obx(() {
              var totalTodos = homeController.doingTodos.length + homeController.doneTodos.length;

              return Padding(
                padding: EdgeInsets.only(top: 3.0.wp, left: 16.0.wp, right: 16.0.wp),
                child: Row(
                  children: <Widget>[
                    Text(
                      "$totalTodos Tasks",
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 3.0.wp),
                    Expanded(
                      child: StepProgressIndicator(
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                        currentStep: homeController.doneTodos.length,
                        size: 5,
                        padding: 0,
                        selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [color.withOpacity(0.5), color],
                        ),
                        unselectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[300]!, Colors.grey[300]!],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 2.0.wp),
              child: TextFormField(
                controller: homeController.editController,
                autofocus: true,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  prefixIcon: Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.grey[400]!,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (homeController.formKey.currentState!.validate()) {
                        var success = homeController.addTodo(homeController.editController.text);

                        if (success) {
                          EasyLoading.showSuccess("Todo item add success");
                        } else {
                          EasyLoading.showSuccess("Todo item already exists");
                        }

                        homeController.editController.clear();
                      }
                    },
                    icon: Icon(Icons.done),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter yout todo item";
                  }
                  return null;
                },
              ),
            ),
            DoingList(),
          ],
        ),
      ),
    );
  }
}
