import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:teacher_rating/commons/constants/network_constants.dart';
import 'package:teacher_rating/commons/constants/prefs_keys.dart';
import 'package:teacher_rating/commons/services/injection_container.dart';
import 'package:teacher_rating/commons/typedefs/typedef.dart';
import 'package:teacher_rating/data/models/comments_by_teacher_id_model.dart';
import 'package:teacher_rating/data/models/students_model.dart';
import 'package:teacher_rating/data/models/teachers_model.dart';

class RatingDatasource {
  //getting all teachers from api
  Future<TeachersData> getTeachers() async {
    try {
      final response =
          await http.get(Uri.parse(NetworkConstants.allTeachersUrl));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final teachers = TeachersModel.fromJson(body);
        return Right(teachers);
      } else {
        return Left('Failed to load teachers: ${response.statusCode}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  //getting comments by teacher ID
  Future<Either<String, CommentsByTeacherIdModel>> getCommentsByTeachersId(
      {required String teacherID}) async {
    final url = Uri.parse(
      "${NetworkConstants.getCommentsByTeachersId}/$teacherID",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final commentsByTeacherId = CommentsByTeacherIdModel.fromJson(body);

        return Right(commentsByTeacherId);
      } else {
        return Left("Failed to load teachers: ${response.statusCode}");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  //get student data by Id
  Future<Either<String, Student>> getStudentByID(
      {required String studentId}) async {
    final url = Uri.parse("${NetworkConstants.getStudentById}/$studentId");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final student = Student.fromJson(body["student"]);
        log(body["student"].toString());
        return Right(student);
      } else {
        log("Failed to load student by id");
        return Left("Student not found");
      }
    } catch (e) {
      log("Error $e");
      return Left("Unknown error");
    }
  }

  //add new comment
  Future<Either<String, String>> addNewComment(
      {required String teacherID, required String commentText}) async {
    final url = Uri.parse(NetworkConstants.addComment);
    try {
      final studentId = getIt<SharedPreferences>().getString(PrefsKeys.idKey);
      log("StudentId: $studentId");
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "teacherId": teacherID,
            "studentId": studentId,
            "comment": commentText
          }));
      log("response add comment: ${response.statusCode}");
      if (response.statusCode == 201) {
        return Right("Comment added successfully");
      } else {
        return Left("Error while adding comment");
      }
    } catch (e) {
      log("error: $e");
      return Left("Unknown error");
    }
  }
}
