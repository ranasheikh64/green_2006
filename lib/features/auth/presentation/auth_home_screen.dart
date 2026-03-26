import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_2006/core/constens/app_assets.dart';
import 'package:green_2006/core/constens/app_sizes.dart';
import 'package:green_2006/core/constens/app_strings.dart';
import 'package:green_2006/core/constens/app_text_styles.dart';
import 'package:green_2006/core/widgets/comparison_slider.dart';
import 'package:green_2006/core/widgets/custom_gradient_background.dart';
import 'package:green_2006/core/widgets/custom_gradient_button.dart';
import 'package:green_2006/features/auth/presentation/auth_register_screen.dart';
import 'package:green_2006/features/auth/presentation/auth_login_screen.dart';



class AuthHomeScreen extends StatelessWidget {
  const AuthHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomGradientBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.hPadding.w),
            child: Column(
              children: [
                SizedBox(height: AppSizes.s20.h),
                ComparisonSlider(imagePath: AppAssets.authHome),
                SizedBox(height: AppSizes.s40.h),
                
                Text(AppStrings.appName, style: AppTextStyles.appTitle.copyWith(fontSize: 32.sp)),
                SizedBox(height: AppSizes.s8.h),
                
                Text(
                  AppStrings.onboardingDesc,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.description,
                ),
                
                const Spacer(),
                
                CustomGradientButton(
                  text: AppStrings.getStarted,
                  onPressed: () => _showSignUp(context),
                ),
                
                SizedBox(height: AppSizes.s16.h),
                
                TextButton(
                  onPressed: () => _showLogin(context),
                  child: Text(
                    AppStrings.alreadyHaveAccount,
                    style: AppTextStyles.linkText.copyWith(fontSize: 16.sp),
                  ),
                ),
                
                SizedBox(height: AppSizes.s24.h),
                
                _buildTermsFooter(),
                SizedBox(height: AppSizes.s10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSignUp(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radius)),
      ),
      builder: (context) => const AuthRegisterScreen(),
    );
  }

  void _showLogin(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radius)),
      ),
      builder: (context) => const AuthLoginScreen(),
    );
  }



  Widget _buildTermsFooter() {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.s16.h),
      child: Text.rich(
        TextSpan(
          text: AppStrings.termsNotice,
          style: AppTextStyles.smallText,
          children: [
            TextSpan(
              text: AppStrings.termsOfUse,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            TextSpan(text: AppStrings.and),
            TextSpan(
              text: AppStrings.privacyNotice,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

