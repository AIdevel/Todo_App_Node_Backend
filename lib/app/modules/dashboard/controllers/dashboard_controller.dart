import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/config.dart';

class DashboardController extends GetxController {
  RxList<dynamic> items = <dynamic>[].obs;

  late SharedPreferences pref;
  late String token;
  late String userId;
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  // update Part
  TextEditingController utitle = TextEditingController();
  TextEditingController udesc = TextEditingController();

  void initSharedPref() async {
    pref = await SharedPreferences.getInstance();
    token = pref.getString('token')!;
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);
    userId = jwtDecodedToken["_id"];
    getTodoList(userId);

    print(userId);
  }

  void addToDo() async {
    try {
      if (title.text.isNotEmpty && desc.text.isNotEmpty) {
        var todoBody =
            jsonEncode({"userId": userId, "title": title.text, "desc": desc.text});
        var response = await http.post(Uri.parse(addTodo),
            body: todoBody, headers: {"Content-Type": "application/json"});

        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["status"]) {
          title.clear();
          desc.clear();
          Get.back();
          getTodoList(userId);
        }
      } else {
        Get.snackbar("Error", "Failed to Save !");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getTodoList(userId) async {
    try {
      var regBody = jsonEncode({"userId": userId});

      var response = await http.post(
        Uri.parse(getToDoList),
        headers: {'Content-Type': 'application/json'},
        body: regBody,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        items.value = jsonResponse['success'];
      }
    } catch (err) {
      print(err.toString());
    }
  }

  // void updateTodo(id) async {
  //   try {
  //     if (utitle.text.isNotEmpty && udesc.text.isNotEmpty) {
  //       var todoBody = jsonEncode({"id": id, "title": utitle.text, "desc": udesc.text});
  //       var response = await http.post(Uri.parse(updateTodoDate),
  //           body: todoBody, headers: {'Content-Type': 'application/json'});
  //       var jsonResponse = jsonDecode(response.body);
  //       if (jsonResponse['status']) {
  //         getTodoList(userId);
  //         Get.back();
  //       }
  //     }
  //   } catch (err) {
  //     print(err.toString());
  //   }
  // }

  void deleteTodo(id) async {
    try {
      var regBody = jsonEncode({"id": id});
      var response = await http.post(Uri.parse(deleteTodoData),
          body: regBody, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status']) {
          getTodoList(userId);
        }
      }
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    initSharedPref();

    // Get.arguments['token'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
