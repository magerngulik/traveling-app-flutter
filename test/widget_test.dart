// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healing_apps/data/healing_services/healing_service.dart';

import 'package:healing_apps/main.dart';

void main() async {
  var dio = Dio();
  var data = HealingServices(dioClient: dio);

  var test = await data.getPackage();
  test.fold((l) {
    print("data error: ${l}");
  }, (r) {
    print("data berhasil: ${r}");
  });
}
