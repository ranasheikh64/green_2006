import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_2006/core/constens/app_sizes.dart';
import 'package:green_2006/core/constens/app_strings.dart';
import 'package:green_2006/core/constens/app_text_styles.dart';
import 'package:green_2006/core/widgets/custom_gradient_button.dart';
import 'package:green_2006/core/widgets/custom_text_field.dart';
import 'package:green_2006/features/auth/presentation/auth_forget_password_verify_otp_screen.dart';

class AuthForgotPasswordEmailScreen extends StatelessWidget {
  const AuthForgotPasswordEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ForgotPasswordContent();
  }
}

class _ForgotPasswordContent extends StatefulWidget {
  const _ForgotPasswordContent();

  @override
  State<_ForgotPasswordContent> createState() => _ForgotPasswordContentState();
}

class _ForgotPasswordContentState extends State<_ForgotPasswordContent> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppSizes.hPadding.w, right: AppSizes.hPadding.w, top: AppSizes.s8.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSizes.vPadding.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radius)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDragHandle(),
              _buildHeader(context),
              _buildTitleSection(),
              SizedBox(height: AppSizes.s32.h),
              
              CustomTextField(controller: _emailController, hintText: AppStrings.emailHint, keyboardType: TextInputType.emailAddress),
              SizedBox(height: AppSizes.s32.h),
              
              _buildSubmitButton(),
              SizedBox(height: AppSizes.s24.h),
              _buildBackToLogin(),
              SizedBox(height: AppSizes.s10.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDragHandle() => Center(
    child: Container(
      width: 48.w, height: AppSizes.s4.h,
      margin: EdgeInsets.only(bottom: AppSizes.s16.h),
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
    ),
  );

  Widget _buildHeader(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
      Text(AppStrings.appName, style: AppTextStyles.appTitle),
      IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: Colors.grey.shade400)),
    ],
  );

  Widget _buildTitleSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: AppSizes.s24.h),
      Text(AppStrings.forgotPasswordTitle, style: AppTextStyles.heading),
      SizedBox(height: AppSizes.s8.h),
      Text(AppStrings.forgotPasswordDesc, style: AppTextStyles.subHeading.copyWith(color: Colors.grey.shade600)),
    ],
  );

  Widget _buildSubmitButton() => CustomGradientButton(
    text: AppStrings.sendCode,
    onPressed: () {
      if (_formKey.currentState!.validate()) {
        Navigator.pop(context);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radius)),
          ),
          builder: (context) => AuthForgotPasswordVerifyOtpScreen(email: _emailController.text),
        );
      }
    },
  );

  Widget _buildBackToLogin() => Center(
    child: TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(AppStrings.backToLogin, style: AppTextStyles.linkText),
    ),
  );
}
