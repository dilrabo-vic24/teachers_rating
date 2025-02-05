import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:teacher_rating/data/models/teachers_model.dart';
import 'package:teacher_rating/presentations/screens/comments_screen.dart';
import 'package:teacher_rating/presentations/utils/app_colors.dart';
import 'package:teacher_rating/presentations/widgets/custom_text_style.dart';
import 'package:teacher_rating/providers/rating_provider.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({super.key});
  static const String path = "/teachers/teacherID";

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RatingProvider>(context, listen: false).getAllTeachers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final teachersProvider = context.watch<RatingProvider>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 60.h,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomTextStyle(text: "Teachers"),
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: const Stack(
                fit: StackFit.expand,
                children: [],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: SearchTeacherDelegate(
                          teachers:
                              teachersProvider.allTeachers.teachers ?? []));
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.all(16.r),
            sliver: SliverList.builder(
              itemCount: teachersProvider.allTeachers.teachers?.length ?? 0,
              itemBuilder: (context, index) {
                final teacher =
                    teachersProvider.allTeachers.teachers?[index].name;
                // log("Teacher: $teacher");
                return InkWell(
                  onTap: () {
                    teachersProvider.getCommentsByTeachersId(
                        teacherID:
                            teachersProvider.allTeachers.teachers![index].id!);
                    context.push(CommentsScreen.path,
                        extra: teachersProvider.allTeachers.teachers![index].id!
                            .toString());
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grayColor.withAlpha(30),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextStyle(
                          text:
                              "NAME: ${teachersProvider.allTeachers.teachers?[index].name}",
                          fontsize: 16.sp,
                        ),
                        CustomTextStyle(
                          text:
                              "SUBJECT: ${teachersProvider.allTeachers.teachers?[index].subject!.toUpperCase()}",
                          fontsize: 14.sp,
                        ),
                        CustomTextStyle(
                          text:
                              "UNIVERSITY: ${teachersProvider.allTeachers.teachers?[index].university!.toUpperCase()}",
                          fontsize: 14.sp,
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow),
                            CustomTextStyle(
                              text: teachersProvider
                                  .allTeachers.teachers![index].averageRating
                                  .toString(),
                              fontsize: 14.sp,
                            ),
                            Spacer(),
                            CustomTextStyle(
                                text: "Comments",
                                // textColor: AppColors.whiteColor,
                                fontsize: 14.sp)
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchTeacherDelegate extends SearchDelegate {
  final List<Teacher> teachers;

  SearchTeacherDelegate({required this.teachers});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = teachers
        .where((teacher) =>
            teacher.name!.toLowerCase().contains(query.toLowerCase()) ||
            teacher.subject!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final teacher = results[index];
        return ListTile(
          title: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
              children: [
                TextSpan(
                    text: teacher.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: " (${teacher.subject})",
                    style: const TextStyle(fontStyle: FontStyle.italic)),
              ],
            ),
          ),
          onTap: () {
            close(context, teacher.name);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = teachers
        .where((teacher) =>
            teacher.name!.toLowerCase().contains(query.toLowerCase()) ||
            teacher.subject!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final teacher = suggestions[index];
        return ListTile(
          title: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
              children: [
                TextSpan(
                    text: teacher.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text: " (${teacher.subject})",
                    style: const TextStyle(fontStyle: FontStyle.italic)),
              ],
            ),
          ),
          onTap: () {
            close(context, teacher.name);
          },
        );
      },
    );
  }
}
