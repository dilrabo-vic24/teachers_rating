import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:teacher_rating/presentations/screens/register_screen.dart';
import 'package:teacher_rating/presentations/screens/teachers_screen.dart';
import 'package:teacher_rating/presentations/utils/app_colors.dart';
import 'package:teacher_rating/presentations/utils/app_icons.dart';
import 'package:teacher_rating/presentations/widgets/auth_text_button.dart';
import 'package:teacher_rating/presentations/widgets/custom_button.dart';
import 'package:teacher_rating/presentations/widgets/custom_text_style.dart';
import 'package:teacher_rating/presentations/widgets/or_widget.dart';
import 'package:teacher_rating/presentations/widgets/password_text_field.dart';
import 'package:teacher_rating/presentations/widgets/phone_text_field.dart';
import 'package:teacher_rating/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String path = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.all(15.h),
                  child: Column(
                    spacing: 5.h,
                    children: [
                      CustomTextStyle(text: "Login", fontsize: 35.sp),
                      TextButton(
                          onPressed: () {
                            log("go register");
                            context.go(RegisterScreen.path);
                          },
                          child: AuthTextButton(
                              question: "Don't have an account? ",
                              text: "Register")),
                      PhoneTextField(controller: phoneController),
                      SizedBox(height: 20.h),
                      PasswordTextFormField(
                          passwordController: passwordController,
                          authProvider: authProvider),
                      SizedBox(height: 20.h),
                      InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await authProvider.login(
                              phoneNumber: phoneController.text.trim(),
                              password: passwordController.text.trim(),
                            );

                            if (authProvider.message.contains("successfully")) {
                              context.go(TeachersScreen.path);
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: CustomTextStyle(
                                  text: authProvider.message,
                                ),
                              ),
                            );
                          }
                        },
                        child: CustomButton(
                            text: "Log In",
                            fontSize: 16.sp,
                            bordercolor: AppColors.grayColor),
                      ),
                      SizedBox(height: 15.h),
                      OrWidget(
                        screenWidth: screenWidth,
                      ),
                      SizedBox(height: 15.h),
                      CustomButton(
                          text: "Log In with Google",
                          fontSize: 16.sp,
                          bordercolor: AppColors.grayColor,
                          imagePath: AppIcons.googleIcon),
                      SizedBox(height: 10.h),
                      CustomButton(
                          text: "Log In with Facebook",
                          fontSize: 16.sp,
                          bordercolor: AppColors.grayColor,
                          imagePath: AppIcons.facebookIcon),
                    ],
                  ),
                ),
              ),
            )));
  }
}
