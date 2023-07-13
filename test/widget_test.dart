// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:healing_apps/data/healing_services/healing_service.dart';
import 'package:logger/logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  var dio = Dio();
  var data = HealingServices(dioClient: dio);
  final logger = Logger();
  // await testLoginService(data, "member@gmail.com", "password");
  // await testget(data, "Get Country");
  // await testgetCountryByid(data, "Get Country by ID", 5);
  // await testingLogout(
  //data, "Testing Logout", "67|V1SZjPDj5eALyFR71G2pEbRqcqgRd9zddQ3qlCbC");
  // await testgetDestination(data, "All Destination", logger);

  test('Testing name', () {
    var response = sayHello("Ojan");
    expect(response, "Hallo, Ojan");
  });

  test("Testing url", () async {
    var response = await getData();
    expect(response, 200);
  });
}

String sayHello(String name) {
  return "Hello, $name";
}

getData() async {
  var response = await Dio().get(
    "https://reqres.in/api/users",
    options: Options(
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );
  return response.statusCode;
}

Future<void> testLoginService(
    HealingServices data, String email, String password, Logger logger) async {
  var testingLoginService = await data.login(email: email, password: password);
  testingLoginService.fold(
    (l) {
      logger.w(l);
    },
    (r) {
      logger.v(r);
    },
  );
}

Future<void> testgetDestination(
    HealingServices data, String title, Logger logger) async {
  var testingLoginService = await data.getDestination();
  debugPrint(title);
  testingLoginService.fold(
    (l) {
      logger.w(l);
    },
    (r) {
      logger.v(r);
    },
  );
}

Future<void> testget(HealingServices data, String title, Logger logger) async {
  var testingLoginService = await data.getCountry();
  debugPrint(title);
  testingLoginService.fold(
    (l) {
      logger.w(l);
    },
    (r) {
      logger.v(r);
    },
  );
}

Future<void> testgetCountryByid(
    HealingServices data, String title, int id, Logger logger) async {
  var testingLoginService = await data.getPackageByCountryId(id: id);
  debugPrint(title);
  testingLoginService.fold(
    (l) {
      logger.w(l);
    },
    (r) {
      logger.v(r);
    },
  );
}

Future<void> testingLogout(
    HealingServices data, String title, String token, Logger logger) async {
  var testingLoginService = await data.logout(token: token);
  debugPrint(title);
  testingLoginService.fold(
    (l) {
      logger.w(l);
    },
    (r) {
      logger.v(r);
    },
  );
}
