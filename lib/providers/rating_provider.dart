import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:teacher_rating/commons/typedefs/typedef.dart';
import 'package:teacher_rating/data/datasource/rating_datasource.dart';
import 'package:teacher_rating/data/models/comments_by_teacher_id_model.dart';
import 'package:teacher_rating/data/models/students_model.dart';
import 'package:teacher_rating/data/models/teachers_model.dart';

class RatingProvider extends ChangeNotifier {
  final RatingDatasource remoteDatasource;

  RatingProvider({required this.remoteDatasource});

  bool isLoading = false;
  String message = "";

  List<Student> students = [];

  TeachersModel allTeachers = TeachersModel();

  CommentsByTeacherIdModel commentsByTeacherId = CommentsByTeacherIdModel();
  Student student = Student();

  //getting all teachers from remoteDatasource
  Future<void> getAllTeachers() async {
    isLoading = true;
    notifyListeners();

    final TeachersData result = await remoteDatasource.getTeachers();
    log("nimadir $result");

    result.fold(
      (l) => message = "Error while getting teachers data",
      (r) => allTeachers = r,
    );
    isLoading = false;
    notifyListeners();
  }

  //get comments by teacher ID
  Future<void> getCommentsByTeachersId({required String teacherID}) async {
    students.clear();
    isLoading = true;
    notifyListeners();

    final result =
        await remoteDatasource.getCommentsByTeachersId(teacherID: teacherID);
    result.fold((l) => message = "Error while loading comments", (r) async {
      commentsByTeacherId = r;

      log("length of comments : ${commentsByTeacherId.comments?.length}");
    });

    await getStudents();

    isLoading = false;
    notifyListeners();
  }

  Future<Student?> getStudentByID({required String studentId}) async {
    final result = await remoteDatasource.getStudentByID(studentId: studentId);

    return result.fold((l) {
      message = l;
      return null;
    }, (r) {
      return r;
    });
  }

  Future<void> getStudents() async {
    if (commentsByTeacherId.comments != null) {
      final futures = commentsByTeacherId.comments!.map((comment) async {
        final result = await remoteDatasource.getStudentByID(
            studentId: comment.studentId.toString());
        return result.fold<Student?>(
          (l) {
            message = l;
            return null;
          },
          (r) => r,
        );
      }).toList();

      final fetchedStudents = await Future.wait(futures);

      students = fetchedStudents.whereType<Student>().toList();

      notifyListeners();
    }
  }

  //add new comment
  Future<void> addNewComment(
      {required String teacherID, required String commentText}) async {
    isLoading = true;
    notifyListeners();

    final result = await remoteDatasource.addNewComment(
        teacherID: teacherID, commentText: commentText);

    result.fold(
      (l) => message = l,
      (r) => message = r,
    );

    await getCommentsByTeachersId(teacherID: teacherID);
    isLoading = false;
    notifyListeners();
  }
}
