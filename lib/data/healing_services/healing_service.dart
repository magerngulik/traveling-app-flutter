// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HealingServices {
  final Dio dioClient;
  HealingServices({
    required this.dioClient,
  });
  String baseUrl = "http://healing-app.test/api/package";
  Future<Either<String, List<Map<String, dynamic>>>> getPackage() async {
    try {
      final response = await dioClient.get(baseUrl);
      Map obj = response.data;
      return Right(List<Map<String, dynamic>>.from(obj['data']));
    } catch (e) {
      return Left(e.toString());
    }
  }

  testPackage() async {
    var response = await Dio().get(
      "http://healing-app.test/api/package",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    Map obj = response.data;
    return obj;
  }
}
