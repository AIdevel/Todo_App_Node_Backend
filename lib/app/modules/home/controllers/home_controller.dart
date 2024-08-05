import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../config.dart';

class HomeController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void registrationUser() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      //body
      var regBody = {
        "email": email.text,
        "password": password.text,
      };
      try {
        var response = await http.post(
          Uri.parse(registration),
          body: jsonEncode(regBody),
          headers: {"Content-Type": "application/json"},
        );
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["status"]) {
          Get.offNamed('./login-page');
        } else {
          Get.snackbar("Error", 'Failed to Register');
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      Get.snackbar("Error", "Registration Failure!");
    }
  }
}
