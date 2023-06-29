// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healing_apps/data/healing_services/healing_service.dart';

void main() async {
  var dio = Dio();
  var data = HealingServices(dioClient: dio);
  await testLoginService(data, "member@gmail.com", "password");
  await testget(data, "Get Country");
}

Future<void> testLoginService(
    HealingServices data, String email, String password) async {
  var testingLoginService = await data.login(email: email, password: password);
  testingLoginService.fold(
    (l) {
      debugPrint('Error type: $l');
    },
    (r) {
      debugPrint('Get data: $r');
    },
  );
}

Future<void> testget(HealingServices data, String title) async {
  var testingLoginService = await data.getCountry();
  debugPrint(title);
  testingLoginService.fold(
    (l) {
      debugPrint('Error type: $l');
      ('Error type: $l');
    },
    (r) {
      debugPrint('Error type: $r');
    },
  );
}
