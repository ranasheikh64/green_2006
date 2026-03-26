import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_2006/core/constens/app_colors.dart';

class AppTextStyles {
  static TextStyle heading = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle subHeading = TextStyle(
    fontSize: 14.sp,
    color: Colors.grey,
  );

  static TextStyle fieldLabel = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle appTitle = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.gradientStart,
  );

  static TextStyle buttonText = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle linkText = TextStyle(
    color: AppColors.gradientStart,
    fontWeight: FontWeight.bold,
    fontSize: 14.sp,
  );

  static TextStyle description = TextStyle(
    fontSize: 16.sp,
    color: Colors.black.withOpacity(0.7),
    fontWeight: FontWeight.w500,
  );

  static TextStyle smallText = TextStyle(
    fontSize: 12.sp,
    color: Colors.grey,
  );
}

