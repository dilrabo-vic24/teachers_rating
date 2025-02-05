// To parse this JSON data, do
//
//     final studentsModel = studentsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'students_model.g.dart';

@JsonSerializable()
class StudentsModel {
  @JsonKey(name: "students")
  final List<Student>? students;

  StudentsModel({
    this.students,
  });

  factory StudentsModel.fromJson(Map<String, dynamic> json) =>
      _$StudentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentsModelToJson(this);
}

@JsonSerializable()
class Student {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "phoneNumber")
  final String? phoneNumber;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;

  Student({
    this.id,
    this.name,
    this.phoneNumber,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
