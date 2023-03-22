import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todoapp/app/core/utils/extensions.dart';
import 'package:todoapp/app/data/models/task.dart';
import 'package:todoapp/app/modules/home/controller.dart';
import 'package:todoapp/app/widgets/icons.dart';

import '../../../core/values/colors.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;

    return Container(
      width: squareWidth / 2,
      height: squareWidth,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          print("tap add");
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: 'Task Type',
            content: Form(
              key: homeController.formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: homeController.editController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Title",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please, enter your task title";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                    child: Wrap(
                      spacing: 2.0.wp,
                      children: icons
                          .map((item) => Obx(() {
                                final index = icons.indexOf(item);
                                return ChoiceChip(
                                  label: item,
                                  selectedColor: Colors.grey[200],
                                  pressElevation: 0,
                                  backgroundColor: Colors.white,
                                  selected: homeController.chipIndex.value == index,
                                  onSelected: (bool selected) {
                                    print("inex selecionado $selected");
                                    homeController.chipIndex.value = selected ? index : 0;
                                  },
                                );
                              }))
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(150, 40),
                    ),
                    onPressed: () {
                      print("submit");

                      if (homeController.formKey.currentState!.validate()) {
                        int icon = icons[homeController.chipIndex.value].icon!.codePoint;
                        String color = icons[homeController.chipIndex.value].color!.toHex();

                        var task = new Task(
                          title: homeController.editController.text,
                          icon: icon,
                          color: color,
                        );

                        Get.back();
                        homeController.addTask(task) ? EasyLoading.showSuccess("Create success") : EasyLoading.showError("Duplicated task");
                      }
                    },
                    child: Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        child: DottedBorder(
            color: Colors.grey[400]!,
            dashPattern: const [8, 4],
            child: Center(
              child: Icon(
                Icons.add,
                size: 10.0.wp,
                color: Colors.grey,
              ),
            )),
      ),
    );
  }
}
