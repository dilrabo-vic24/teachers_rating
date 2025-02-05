import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:teacher_rating/presentations/screens/login_screen.dart';
import 'package:teacher_rating/presentations/screens/teachers_screen.dart';
import 'package:teacher_rating/presentations/utils/app_colors.dart';
import 'package:teacher_rating/presentations/utils/app_icons.dart';
import 'package:teacher_rating/presentations/widgets/auth_text_button.dart';
import 'package:teacher_rating/presentations/widgets/custom_button.dart';
import 'package:teacher_rating/presentations/widgets/custom_text_field.dart';
import 'package:teacher_rating/presentations/widgets/custom_text_style.dart';
import 'package:teacher_rating/presentations/widgets/or_widget.dart';
import 'package:teacher_rating/presentations/widgets/password_text_field.dart';
import 'package:teacher_rating/presentations/widgets/phone_text_field.dart';
import 'package:teacher_rating/providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String path = "/register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: Column(
                spacing: 5.h,
                children: [
                  CustomTextStyle(text: "Register", fontsize: 35.sp),
                  TextButton(
                      onPressed: () {
                        context.push(LoginScreen.path);
                      },
                      child: AuthTextButton(
                          question: "Already have an account? ",
                          text: "Login")),
                  CustomFormField(
                      controller: nameController,
                      labelText: "Firstname",
                      suffixIcon: Icons.person_2_outlined),
                  SizedBox(height: 20.h),
                  PhoneTextField(controller: phoneController),
                  SizedBox(height: 20.h),
                  PasswordTextFormField(
                      passwordController: passwordController,
                      authProvider: authProvider),
                  SizedBox(height: 25.h),
                  InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await authProvider.register(
                          name: nameController.text.trim(),
                          phoneNumber: phoneController.text.trim(),
                          password: passwordController.text.trim(),
                        );

                        if (authProvider.message.contains("successfully")) {
                          context.go(TeachersScreen.path);
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.darkGreyColor,
                            content: CustomTextStyle(
                              text: authProvider.message,
                            ),
                          ),
                        );
                      }
                    },
                    child: CustomButton(
                        text: "Register",
                        fontSize: 16.sp,
                        bordercolor: AppColors.grayColor),
                  ),
                  SizedBox(height: 10.h),
                  OrWidget(screenWidth: screenWidth),
                  SizedBox(height: 10.h),
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
        ),
      ),
    );
  }
}
