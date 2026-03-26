import 'package:flutter/material.dart';
import 'package:green_2006/core/constens/app_colors.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),

          // 🔥 Gradient
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
          ),

          // 🔥 Shadow (outer + inner feel)
          boxShadow: [
            // Outer shadow
            BoxShadow(
              color: Colors.white.withOpacity(0.25),
              offset: const Offset(0, 1),
              blurRadius: 1,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.25),
              offset: const Offset(0, -1),
              blurRadius: 1,
            ),
          ],
        ),

        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
