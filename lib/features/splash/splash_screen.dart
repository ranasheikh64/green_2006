import 'dart:async';
import 'package:flutter/material.dart';
import 'package:green_2006/core/constens/app_colors.dart';
import 'package:green_2006/core/constens/app_strings.dart';
import 'package:green_2006/core/widgets/custom_gradient_background.dart';
import 'package:green_2006/features/auth/presentation/auth_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthHomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomGradientBackground(
        child: Center(
          child: Text(
            AppStrings.appName,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: AppColors.gradientStart,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

