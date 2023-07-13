import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:healing_apps/data/healing_services/healing_service.dart';

void main() {
  Dio dioClient = Dio();
  var data = HealingServices(dioClient: dioClient);

  test('api get Destination', () async {
    var response = await data.getPackage();
    expect(response.isRight(), true);
    expect(response.isLeft(), false);
  });

  test("api get package by destination", () async {
    var response = await data.getPackagebyDestination(id: 7);
    expect(response.isRight(), true);
    expect(response.isLeft(), false);
  });
}
