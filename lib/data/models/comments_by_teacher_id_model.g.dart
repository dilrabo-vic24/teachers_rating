// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_by_teacher_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentsByTeacherIdModel _$CommentsByTeacherIdModelFromJson(
        Map<String, dynamic> json) =>
    CommentsByTeacherIdModel(
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentsByTeacherIdModelToJson(
        CommentsByTeacherIdModel instance) =>
    <String, dynamic>{
      'comments': instance.comments,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['_id'] as String?,
      teacherId: json['teacherId'] as String?,
      studentId: json['studentId'] as String?,
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      '_id': instance.id,
      'teacherId': instance.teacherId,
      'studentId': instance.studentId,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
