import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher_rating/commons/constants/network_constants.dart';
import 'package:teacher_rating/commons/constants/prefs_keys.dart';
import 'package:teacher_rating/commons/services/injection_container.dart';

class AuthDataSource {
  //register student
  Future<Either<String, String>> register(
      String name, String phoneNumber, String password) async {
    try {
      final response = await http.post(
        Uri.parse(NetworkConstants.studentRegisterUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'phoneNumber': "${phoneNumber.substring(0, 2)}-"
              "${phoneNumber.substring(2, 5)}-"
              "${phoneNumber.substring(5, 7)}-"
              "${phoneNumber.substring(7, 9)}",
          'password': password,
        }),
      );
      log(response.body);
      log(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        final prefs = getIt<SharedPreferences>()
            .setString(PrefsKeys.idKey, body["newStudent"]["_id"]);
        log("success right");
        return Right("Registered successfully");
      } else {
        log("error else");
        return Left(
            "User already exists");
      }
    } catch (e) {
      log('Registration error: ${e.toString()}');
      return Left('Unknown error');
    }
  }

//login student
  Future<Either<String, String>> login(
      String phoneNumber, String password) async {
    try {
      final response = await http.post(
        Uri.parse(NetworkConstants.studentLoginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phoneNumber': "${phoneNumber.substring(0, 2)}-"
              "${phoneNumber.substring(2, 5)}-"
              "${phoneNumber.substring(5, 7)}-"
              "${phoneNumber.substring(7, 9)}", //000000000
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        final prefs = getIt<SharedPreferences>()
            .setString(PrefsKeys.idKey, body["student_id"]);
        log("logged successfully");
        return Right("Login successfully");
      } else {
        log('Login failed: ${response.statusCode} - ${response.body}');
        return Left("Password or phone nomer are incorrect");
      }
    } catch (e) {
      log("Login error: ${e.toString()}");
      return Left('Unknown error');
    }
  }
}
