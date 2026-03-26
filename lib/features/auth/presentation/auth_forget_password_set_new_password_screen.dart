import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_2006/core/constens/app_sizes.dart';
import 'package:green_2006/core/constens/app_strings.dart';
import 'package:green_2006/core/constens/app_text_styles.dart';
import 'package:green_2006/core/widgets/custom_gradient_button.dart';
import 'package:green_2006/core/widgets/custom_text_field.dart';

class AuthForgetPasswordSetNewPasswordScreen extends StatelessWidget {
  const AuthForgetPasswordSetNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SetNewPasswordContent();
  }
}

class _SetNewPasswordContent extends StatefulWidget {
  const _SetNewPasswordContent();

  @override
  State<_SetNewPasswordContent> createState() => _SetNewPasswordContentState();
}

class _SetNewPasswordContentState extends State<_SetNewPasswordContent> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              
              _buildPasswordField(
                controller: _passwordController,
                hintText: "12345678",
                obscureText: _obscurePassword,
                onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
              SizedBox(height: AppSizes.s16.h),
              _buildPasswordField(
                controller: _confirmPasswordController,
                hintText: AppStrings.confirmPassword,
                obscureText: _obscureConfirmPassword,
                onToggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
              ),
              SizedBox(height: AppSizes.s32.h),
              
              _buildSubmitButton(),
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
      Text(AppStrings.setNewPassword, style: AppTextStyles.heading),
      SizedBox(height: AppSizes.s8.h),
      Text(AppStrings.setNewPasswordDesc, style: AppTextStyles.subHeading.copyWith(color: Colors.grey.shade600)),
    ],
  );

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      obscureText: obscureText,
      suffixIcon: IconButton(
        icon: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey),
        onPressed: onToggle,
      ),
    );
  }

  Widget _buildSubmitButton() => CustomGradientButton(
    text: AppStrings.sendCode,
    onPressed: () {
      if (_formKey.currentState!.validate()) {
        // Handle password reset
      }
    },
  );
}
