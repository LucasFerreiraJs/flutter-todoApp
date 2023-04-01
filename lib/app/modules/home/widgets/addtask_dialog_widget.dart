import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todoapp/app/core/utils/extensions.dart';
import 'package:todoapp/app/modules/home/home_controller.dart';

class AddTaskDialogWidget extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddTaskDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeController.formKey,
        child: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(3.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Get.back();
                    homeController.editController.clear();
                    homeController.changeTask(null);
                  },
                  icon: const Icon(Icons.close),
                ),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    if (homeController.formKey.currentState!.validate()) {
                      if (homeController.taskSelected.value == null) {
                        EasyLoading.showError("Please, select task type");
                      } else {
                        var success = homeController.updateTask(homeController.taskSelected.value!, homeController.editController.text);
                        if (success) {
                          EasyLoading.showSuccess("Todo item add success!");
                          Get.back();
                          homeController.changeTask(null);
                        } else {
                          EasyLoading.showError("Todo item already exist");
                        }
                        homeController.editController.clear();
                      }
                    }
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 14.0.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
            child: Text(
              "New Task",
              style: TextStyle(
                fontSize: 20.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
            child: TextFormField(
                controller: homeController.editController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                }),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0.wp, left: 5.0.wp, bottom: 2.0.wp),
            child: Text(
              'Add to',
              style: TextStyle(
                fontSize: 14.0.sp,
                color: Colors.grey,
              ),
            ),
          ),
          ...homeController.taskList
              .map(
                (item) => Obx(
                  () => InkWell(
                    onTap: () {
                      homeController.changeTask(item);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 3.0.wp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                IconData(
                                  item.icon,
                                  fontFamily: 'MaterialIcons',
                                ),
                                color: HexColor.fromHex(item.color),
                              ),
                              SizedBox(width: 3.0.wp),
                              Text(
                                item.title,
                                style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          if (homeController.taskSelected.value == item) const Icon(Icons.check, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ]),
      ),
    );
  }
}
