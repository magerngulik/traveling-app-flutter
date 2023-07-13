// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HealingServices {
  final Dio dioClient;
  HealingServices({
    required this.dioClient,
  });
  String baseUrl = "https://servicesimager.my.id/";
  Future<Either<String, List<Map<String, dynamic>>>> getPackage() async {
    try {
      final response = await dioClient.get("${baseUrl}api/package/active");
      Map obj = response.data;
      return Right(List<Map<String, dynamic>>.from(obj['data']));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> getDestination() async {
    try {
      final response = await dioClient.get("${baseUrl}api/destination");
      Map obj = response.data;
      return Right(List<Map<String, dynamic>>.from(obj['data']));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Map>> login(
      {required String email, required String password}) async {
    try {
      var response = await dioClient.post(
        "${baseUrl}api/auth/login",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: {
          "email": email,
          "password": password,
        },
      );
      Map obj = response.data['data'];

      return Right(obj);
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          Map<String, dynamic>? responseMap =
              e.response?.data as Map<String, dynamic>?;
          String errorMessage = responseMap?['message'] ??
              "Unauthorized. Please check your credentials.";
          return Left(errorMessage);
        }
        return const Left(
            "Server sedang maintance harap login beberapa saat lagi");
      } else {
        return Left(e.toString());
      }
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> getCountry() async {
    try {
      var response = await dioClient.get(
        "${baseUrl}api/location/get-country",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      Map obj = response.data;
      return Right(List<Map<String, dynamic>>.from(obj['data']));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> getPackageByCountryId(
      {required int id}) async {
    try {
      var response = await dioClient.get(
        "${baseUrl}api/get-by-location-id?country_id=$id",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );
      Map obj = response.data;
      return Right(List<Map<String, dynamic>>.from(obj['data']));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> logout({required String token}) async {
    try {
      var response = await dioClient.get(
        "${baseUrl}api/auth/logout",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );
      Map obj = response.data;
      String message = obj['message'];
      return Right(message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Map<String, dynamic>>>> getPackagebyDestination(
      {required int id}) async {
    try {
      var response = await dioClient.get(
        "${baseUrl}api/package/destination/$id",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      Map obj = response.data;
      return Right(List<Map<String, dynamic>>.from(obj['data']));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
