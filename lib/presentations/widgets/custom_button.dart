import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacher_rating/presentations/widgets/custom_text_style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String? imagePath;
  final Color bordercolor;
  final double fontSize;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.fontSize,
    required this.bordercolor,
    this.imagePath,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 330.w,
        height: 45.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: bordercolor),
        ),
        child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      imagePath != null ? Image.asset(imagePath!) : SizedBox(),
                      SizedBox(width: 4.w),
                      CustomTextStyle(text: text, fontsize: fontSize),
                    ],
                  )));
  }
}
