import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_2006/core/constens/app_sizes.dart';
import 'package:green_2006/core/constens/app_strings.dart';
import 'package:green_2006/core/constens/app_text_styles.dart';
import 'package:green_2006/core/widgets/custom_gradient_button.dart';
import 'package:green_2006/core/widgets/custom_text_field.dart';
import 'package:green_2006/features/auth/presentation/auth_login_screen.dart';
import 'bloc/auth_bloc.dart';

import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';



class AuthRegisterScreen extends StatelessWidget {
  const AuthRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _RegisterContent();
  }
}

class _RegisterContent extends StatefulWidget {
  const _RegisterContent();

  @override
  State<_RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<_RegisterContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    for (var c in [_nameController, _emailController, _passwordController]) {
      c.dispose();
    }
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(AppStrings.registrationSuccess)));
          } else if (state.status == AuthStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? AppStrings.registrationFailed)));
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
                _buildHeader(context),
                _buildTitleSection(),
                SizedBox(height: AppSizes.s32.h),
                
                _buildField(AppStrings.fullName, _nameController, AppStrings.enterName),
                SizedBox(height: AppSizes.s16.h),
                _buildField(AppStrings.enterEmail, _emailController, AppStrings.emailHint, type: TextInputType.emailAddress),
                SizedBox(height: AppSizes.s16.h),
                _buildPasswordField(),
                
                SizedBox(height: AppSizes.s16.h),
                _buildTermsNotice(),
                SizedBox(height: AppSizes.s24.h),
                
                _buildSubmitButton(),
                SizedBox(height: AppSizes.s24.h),
                _buildDivider(),
                SizedBox(height: AppSizes.s24.h),
                _buildGoogleButton(),
                SizedBox(height: AppSizes.s24.h),
                _buildLoginFooter(),
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

  Widget _buildHeader(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
      Text(AppStrings.appName, style: AppTextStyles.appTitle),
      IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: Colors.grey.shade400)),
    ],
  );

  Widget _buildTitleSection() => Column(
    children: [
      Text(AppStrings.signUp, style: AppTextStyles.heading),
      Text(AppStrings.createAccountDesc, style: AppTextStyles.subHeading),
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

  Widget _buildTermsNotice() => Text.rich(
    TextSpan(
      text: AppStrings.agreeNotice,
      style: AppTextStyles.smallText,
      children: [
        TextSpan(text: AppStrings.termsAndConditions, style: AppTextStyles.linkText),
        const TextSpan(text: AppStrings.and),
        TextSpan(text: AppStrings.privacyPolicy, style: AppTextStyles.linkText),
      ],
    ),
    textAlign: TextAlign.center,
  );

  Widget _buildSubmitButton() => BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) => CustomGradientButton(
      text: AppStrings.continueText,
      isLoading: state.status == AuthStatus.loading,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          context.read<AuthBloc>().add(RegisterEvent(
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          ));
        }
      },
    ),
  );

  Widget _buildDivider() => Row(
    children: [
      const Expanded(child: Divider()),
      Padding(padding: EdgeInsets.symmetric(horizontal: AppSizes.s16.w), child: Text(AppStrings.or, style: TextStyle(color: Colors.grey, fontSize: 12.sp))),
      const Expanded(child: Divider()),
    ],
  );

  Widget _buildGoogleButton() => OutlinedButton.icon(
    onPressed: () {},
    icon: const Icon(Icons.g_mobiledata, size: AppSizes.iconSize),
    label: Text(AppStrings.continueWithGoogle, style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600)),
    style: OutlinedButton.styleFrom(
      minimumSize: Size(double.infinity, 56.h),
      backgroundColor: Colors.grey.shade100,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.buttonRadius.r)),
    ),
  );

  Widget _buildLoginFooter() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(AppStrings.alreadyHaveAccountLogin, style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radius)),
            ),
            builder: (context) => const AuthLoginScreen(),
          );
        },
        child: Text(AppStrings.logIn, style: AppTextStyles.linkText),
      ),
    ],
  );
}





