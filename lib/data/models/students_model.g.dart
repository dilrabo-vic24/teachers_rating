// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentsModel _$StudentsModelFromJson(Map<String, dynamic> json) =>
    StudentsModel(
      students: (json['students'] as List<dynamic>?)
          ?.map((e) => Student.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StudentsModelToJson(StudentsModel instance) =>
    <String, dynamic>{
      'students': instance.students,
    };

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      password: json['password'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
