import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:teacher_rating/data/models/students_model.dart';
import 'package:teacher_rating/presentations/utils/app_colors.dart';
import 'package:teacher_rating/presentations/widgets/comments_widget.dart';
import 'package:teacher_rating/presentations/widgets/custom_text_style.dart';
import 'package:teacher_rating/providers/rating_provider.dart';

class CommentsScreen extends StatefulWidget {
  final String teacherID;
  const CommentsScreen({super.key, required this.teacherID});
  static const String path = "/teacherDetails";

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    // final ratingProvider = context.read<RatingProvider>();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<RatingProvider>(
        builder: (context, ratingProvider, child) {
          if (ratingProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (ratingProvider.commentsByTeacherId == null) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          } else if (ratingProvider.commentsByTeacherId.comments == null ||
              ratingProvider.commentsByTeacherId.comments!.isEmpty) {
            return Center(
                child: CustomTextStyle(
              text: "No comments yet",
            ));
          } else {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  children: [
                    CustomTextStyle(
                      text: "Comments from students",
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: ratingProvider
                                .commentsByTeacherId.comments?.length ??
                            0,
                        itemBuilder: (context, index) {
                          final comment = ratingProvider
                              .commentsByTeacherId.comments![index];
                          final student = ratingProvider.students.firstWhere(
                            (student) => student.id == comment.studentId,
                            orElse: () =>
                                Student(),
                          );

                          return CommentsWidget(
                              student: student, commentByTeacherId: comment);
                        },
                      ),
                    ),
                    //
                  ],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.whiteColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SizedBox(
                  height: screenHeight * 0.35,
                  // padding: EdgeInsets.all(20.w),
                  child: Column(
                    spacing: 20.h,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100.h,
                        child: TextField(
                          controller: commentController,
                          style: TextStyle(color: AppColors.darkGreyColor),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r))),
                            hintText: 'Enter comment...',
                          ),
                          maxLines: null,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mainColor),
                          onPressed: () async {
                            if (commentController.text.trim().isNotEmpty) {
                              await context
                                  .read<RatingProvider>()
                                  .addNewComment(
                                      teacherID: widget.teacherID,
                                      commentText: commentController.text);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: CustomTextStyle(
                                    text: context
                                        .read<RatingProvider>()
                                        .message)));
                            context.pop();
                          },
                          child: CustomTextStyle(
                            text: "Add comment",
                          ))
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}
