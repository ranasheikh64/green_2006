import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_2006/core/constens/app_sizes.dart';
import 'package:green_2006/core/constens/app_strings.dart';
import 'package:green_2006/core/constens/app_text_styles.dart';
import 'package:green_2006/core/widgets/custom_gradient_button.dart';
import 'package:green_2006/core/widgets/custom_text_field.dart';
import 'package:green_2006/features/auth/presentation/auth_forget_password_email_screen.dart';
import 'bloc/auth_bloc.dart';

import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';

class AuthLoginScreen extends StatelessWidget {
  const AuthLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LoginContent();
  }
}

class _LoginContent extends StatefulWidget {
  const _LoginContent();

  @override
  State<_LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<_LoginContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.success) {
            Navigator.pop(context);
          } else if (state.status == AuthStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? "Login failed")));
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDragHandle(),
                _buildHeader(),
                _buildTitleSection(),
                SizedBox(height: AppSizes.s32.h),
                
                _buildField(AppStrings.fullName, _emailController, AppStrings.emailHint, type: TextInputType.emailAddress),
                SizedBox(height: AppSizes.s16.h),
                _buildPasswordField(),
                
                SizedBox(height: AppSizes.s16.h),
                _buildRememberForgotRow(),
                SizedBox(height: AppSizes.s32.h),
                
                _buildSubmitButton(),
                SizedBox(height: AppSizes.s40.h),
                _buildFooterLinks(),
                SizedBox(height: AppSizes.s10.h),
              ],
            ),
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

  Widget _buildHeader() => Center(
    child: Text(AppStrings.appName, style: AppTextStyles.appTitle.copyWith(fontSize: 32.sp)),
  );

  Widget _buildTitleSection() => Column(
    children: [
      SizedBox(height: AppSizes.s32.h),
      Text(AppStrings.signIn, style: AppTextStyles.heading),
      Text(AppStrings.loginDesc, style: AppTextStyles.subHeading),
    ],
  );

  Widget _buildField(String label, TextEditingController controller, String hint, {TextInputType? type}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppTextStyles.fieldLabel),
      SizedBox(height: AppSizes.s8.h),
      CustomTextField(controller: controller, hintText: hint, keyboardType: type),
    ],
  );

  Widget _buildPasswordField() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(AppStrings.enterPassword, style: AppTextStyles.fieldLabel),
      SizedBox(height: AppSizes.s8.h),
      CustomTextField(
        controller: _passwordController,
        hintText: AppStrings.passwordHint,
        obscureText: _obscurePassword,
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
      ),
    ],
  );

  Widget _buildRememberForgotRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          SizedBox(
            width: 24.w, height: 24.h,
            child: Checkbox(
              value: _rememberMe,
              onChanged: (v) => setState(() => _rememberMe = v ?? false),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
            ),
          ),
          SizedBox(width: AppSizes.s8.w),
          Text(AppStrings.rememberMe, style: AppTextStyles.smallText.copyWith(color: Colors.black)),
        ],
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radius)),
            ),
            builder: (context) => const AuthForgotPasswordEmailScreen(),
          );

        },
        child: Text(AppStrings.forgotPassword, style: AppTextStyles.linkText),
      ),

    ],
  );

  Widget _buildSubmitButton() => BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) => CustomGradientButton(
      text: AppStrings.signIn,
      isLoading: state.status == AuthStatus.loading,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          context.read<AuthBloc>().add(LoginEvent(
            email: _emailController.text,
            password: _passwordController.text,
          ));
        }
      },
    ),
  );

  Widget _buildFooterLinks() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      TextButton(onPressed: () {}, child: Text(AppStrings.termsAndConditions, style: AppTextStyles.smallText.copyWith(color: Colors.black))),
      Container(width: 1, height: 16.h, color: Colors.grey.shade300),
      TextButton(onPressed: () {}, child: Text(AppStrings.privacyPolicy, style: AppTextStyles.smallText.copyWith(color: Colors.black))),
    ],
  );
}

