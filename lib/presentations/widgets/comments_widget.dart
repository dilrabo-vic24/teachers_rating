import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacher_rating/data/models/comments_by_teacher_id_model.dart';
import 'package:teacher_rating/data/models/students_model.dart';
import 'package:teacher_rating/presentations/widgets/custom_text_style.dart';

class CommentsWidget extends StatelessWidget {
  final Comment? commentByTeacherId;
  final Student student;

  const CommentsWidget({
    super.key,
    required this.commentByTeacherId,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r)),
            color: Colors.grey),
        margin: EdgeInsets.all(5.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomTextStyle(
            text: commentByTeacherId?.createdAt!.substring(0, 10) ?? "",
            fontsize: 16.sp,
          ),
          CustomTextStyle(
            text: commentByTeacherId?.comment! ?? "",
            textAlign: TextAlign.start,
          ),
          CustomTextStyle(text: student.name!),
        ]));
  }
}
