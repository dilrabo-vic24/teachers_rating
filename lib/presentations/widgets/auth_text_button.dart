import 'package:flutter/material.dart';
import 'package:teacher_rating/presentations/utils/app_colors.dart';

class AuthTextButton extends StatelessWidget {
  final String question;
  final String text;
  const AuthTextButton({
    super.key,
    required this.question,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: question, style: TextStyle(color: AppColors.grayColor)),
      TextSpan(text: text, style: TextStyle(color: Colors.blue))
    ]));
  }
}
