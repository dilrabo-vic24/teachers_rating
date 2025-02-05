// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teachers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeachersModel _$TeachersModelFromJson(Map<String, dynamic> json) =>
    TeachersModel(
      teachers: (json['teachers'] as List<dynamic>?)
          ?.map((e) => Teacher.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeachersModelToJson(TeachersModel instance) =>
    <String, dynamic>{
      'teachers': instance.teachers,
    };

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      subject: json['subject'] as String?,
      university: json['university'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'subject': instance.subject,
      'university': instance.university,
      'averageRating': instance.averageRating,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
