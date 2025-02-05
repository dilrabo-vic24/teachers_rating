import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextStyle extends StatelessWidget {
  final String text;
  double? fontsize;
  TextAlign? textAlign;
  Color? textColor; 

  CustomTextStyle({
    super.key,
    required this.text,
    this.fontsize,
    this.textAlign,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final defaultTextColor =
        textColor ?? (isDarkMode ? Colors.white : Colors.black);

    return Text(
      text,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        fontSize: fontsize ?? 20.sp,
        color: defaultTextColor,
      ),
    );
  }
}
