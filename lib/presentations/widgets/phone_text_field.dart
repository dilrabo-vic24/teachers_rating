import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacher_rating/presentations/utils/app_colors.dart';

class PhoneTextField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(color: AppColors.darkGreyColor),
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Ex: 901234567",
        prefixIcon: const Icon(
          Icons.phone,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter phone number";
        }

        if (value.length != 9) {
          return "Phone number consists 7 numbers";
        }
        return null;
      },
    );
  }
}
