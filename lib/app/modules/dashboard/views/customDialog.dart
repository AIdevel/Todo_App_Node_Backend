import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/modules/dashboard/controllers/dashboard_controller.dart';

class CustomDialog extends GetView<DashboardController> {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 12, right: 12, bottom: 12),
        height: Get.height * 0.6,
        width: Get.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const Text(
              "Add To-Do",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              height: Get.height * 0.06,
            ),
            TextFormField(
                controller: controller.title,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Title",
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                )),
            SizedBox(
              height: Get.height * 0.05,
            ),
            TextFormField(
                maxLines: 3,
                controller: controller.desc,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Description",
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                )),
            SizedBox(
              height: Get.height * 0.05,
            ),
            SizedBox(
              width: Get.width * 0.5,
              height: Get.height * 0.055,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    controller.addToDo();
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
