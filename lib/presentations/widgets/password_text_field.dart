import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacher_rating/presentations/utils/app_colors.dart';
import 'package:teacher_rating/providers/auth_provider.dart';

class PasswordTextFormField extends StatelessWidget {
  final TextEditingController passwordController;
  final AuthProvider authProvider;
  const PasswordTextFormField({
    super.key,
    required this.passwordController,
    required this.authProvider,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: authProvider.isVisible,
      style: TextStyle(color: AppColors.darkGreyColor),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        labelText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            authProvider.isVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            authProvider.toggleVisibility();
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        } else if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
    );
  }
}
