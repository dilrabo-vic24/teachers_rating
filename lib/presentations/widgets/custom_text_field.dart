import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacher_rating/presentations/utils/app_colors.dart';

class CustomFormField extends StatelessWidget {
  final String labelText;
  final IconData suffixIcon;
  final TextEditingController? controller;

  const CustomFormField({
    super.key,
    required this.labelText,
    required this.suffixIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: AppColors.darkGreyColor),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(suffixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your name";
        }
        return null;
      },
    );
  }
}
