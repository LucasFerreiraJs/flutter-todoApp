import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/app/core/utils/extensions.dart';
import 'package:todoapp/app/core/values/colors.dart';
import 'package:todoapp/app/modules/home/home_controller.dart';

class DoneListWidget extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DoneListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 2.0.wp),
                  child: Text(
                    'Completed(${homeController.doneTodos.length})',
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                ...homeController.doneTodos
                    .map(
                      (item) => Dismissible(
                        key: ObjectKey(item),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => homeController.deleteDoneTodo(item),
                        background: Container(
                          color: Colors.red.withOpacity(0.8),
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 5.0.wp),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 9.0.wp, vertical: 3.0.wp),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  Icons.done,
                                  color: blue,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                                child: Text(
                                  item['title'],
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            )
          : Container(),
    );
  }
}
