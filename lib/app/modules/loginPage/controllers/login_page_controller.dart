import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  late SharedPreferences prefs;

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      var reqBody = jsonEncode({"email": email.text, "password": password.text});
      try {
        var response = await http.post(
          Uri.parse('http://10.51.3.229:3000/login'),
          headers: {'Content-Type': 'application/json'}, //tum ne hi mna kiya tha dene se
          body: reqBody,
        );
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          var jsonResponse = await jsonDecode(response.body);
          print(jsonResponse);

          if (jsonResponse["status"]) {
            var myToken = jsonResponse['token'];
            prefs.setString('token', myToken);
            Get.offNamed('./dashboard');
          }
        } else {
          print("Something went wrong");
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    initSharedPref();
  }
}
