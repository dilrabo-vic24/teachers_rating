import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacher_rating/presentations/widgets/custom_text_style.dart';

class OrWidget extends StatelessWidget {
  final double screenWidth;
  const OrWidget({
    super.key,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
          height: 10.h,
          width: 0.35 * screenWidth,
          child: Divider(indent: 10.w, endIndent: 10.w, color: Colors.black)),
      CustomTextStyle(text: "OR"),
      SizedBox(
          height: 10,
          width: 0.35 * screenWidth,
          child: Divider(indent: 10, endIndent: 10, color: Colors.black))
    ]);
  }
}
