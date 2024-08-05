import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:todo_app/app/modules/dashboard/views/customDialog.dart';
// import 'package:todo_app/app/modules/dashboard/views/custom_Bottom_sheet.dart';

import '../controllers/dashboard_controller.dart';
// import 'customDialogUpdate.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.lightBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40, left: 20),
                height: Get.height * 0.08,
                width: Get.width * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), color: Colors.white),
                child: const Icon(
                  Icons.list,
                  color: CupertinoColors.activeBlue,
                  size: 28,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  "ToDo with Node Js + Express Js + MongoDB",
                  // controller.userId,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: Get.height * 0.70085,
                  width: Get.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                  child: Obx(
                    () => ListView.separated(
                      itemCount: controller.items.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (BuildContext context) {
                                  controller.deleteTodo(controller.items[index]["_id"]);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                label: 'Delete',
                                icon: Icons.delete,
                              )
                            ],
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.file_copy_outlined,
                              color: Colors.black,
                            ),
                            title: Text(controller.items![index]['title']),
                            subtitle: Text(controller.items![index]['desc']),
                            trailing: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 2,
                          color: CupertinoColors.systemGrey3,
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog();
            },
          );
        },
        backgroundColor: Colors.cyan,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
