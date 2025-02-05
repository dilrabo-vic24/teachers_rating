// To parse this JSON data, do
//
//     final commentsByTeacherIdModel = commentsByTeacherIdModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'comments_by_teacher_id_model.g.dart';

CommentsByTeacherIdModel commentsByTeacherIdModelFromJson(String str) => CommentsByTeacherIdModel.fromJson(json.decode(str));

String commentsByTeacherIdModelToJson(CommentsByTeacherIdModel data) => json.encode(data.toJson());

@JsonSerializable()
class CommentsByTeacherIdModel {
    @JsonKey(name: "comments")
    final List<Comment>? comments;

    CommentsByTeacherIdModel({
        this.comments,
    });

    factory CommentsByTeacherIdModel.fromJson(Map<String, dynamic> json) => _$CommentsByTeacherIdModelFromJson(json);

    Map<String, dynamic> toJson() => _$CommentsByTeacherIdModelToJson(this);
}

@JsonSerializable()
class Comment {
    @JsonKey(name: "_id")
    final String? id;
    @JsonKey(name: "teacherId")
    final String? teacherId;
    @JsonKey(name: "studentId")
    final String? studentId;
    @JsonKey(name: "comment")
    final String? comment;
    @JsonKey(name: "createdAt")
    final String? createdAt;
    @JsonKey(name: "updatedAt")
    final String? updatedAt;

    Comment({
        this.id,
        this.teacherId,
        this.studentId,
        this.comment,
        this.createdAt,
        this.updatedAt,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

    Map<String, dynamic> toJson() => _$CommentToJson(this);
}
