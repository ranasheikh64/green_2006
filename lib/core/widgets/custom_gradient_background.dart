import 'package:flutter/material.dart';
import 'package:green_2006/core/constens/app_colors.dart';

class CustomGradientBackground extends StatelessWidget {
  final Widget child;

  const CustomGradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.bggradientStart,
            AppColors.bggradientEnd,
          ],
        ),
      ),
      child: child,
    );
  }
}
