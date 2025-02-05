// To parse this JSON data, do
//
//     final teachersModel = teachersModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'teachers_model.g.dart';

TeachersModel teachersModelFromJson(String str) => TeachersModel.fromJson(json.decode(str));

String teachersModelToJson(TeachersModel data) => json.encode(data.toJson());

@JsonSerializable()
class TeachersModel {
    @JsonKey(name: "teachers")
    final List<Teacher>? teachers;

    TeachersModel({
        this.teachers,
    });

    factory TeachersModel.fromJson(Map<String, dynamic> json) => _$TeachersModelFromJson(json);

    Map<String, dynamic> toJson() => _$TeachersModelToJson(this);
}

@JsonSerializable()
class Teacher {
    @JsonKey(name: "_id")
    final String? id;
    @JsonKey(name: "name")
    final String? name;
    @JsonKey(name: "subject")
    final String? subject;
    @JsonKey(name: "university")
    final String? university;
    @JsonKey(name: "averageRating")
    final double? averageRating;
    @JsonKey(name: "createdAt")
    final String? createdAt;
    @JsonKey(name: "updatedAt")
    final String? updatedAt;

    Teacher({
        this.id,
        this.name,
        this.subject,
        this.university,
        this.averageRating,
        this.createdAt,
        this.updatedAt,
    });

    factory Teacher.fromJson(Map<String, dynamic> json) => _$TeacherFromJson(json);

    Map<String, dynamic> toJson() => _$TeacherToJson(this);
}
