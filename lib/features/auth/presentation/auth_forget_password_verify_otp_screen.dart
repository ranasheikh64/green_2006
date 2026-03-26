import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:green_2006/core/constens/app_assets.dart';
import 'package:green_2006/core/constens/app_sizes.dart';
import 'package:green_2006/core/constens/app_strings.dart';
import 'package:green_2006/core/constens/app_text_styles.dart';
import 'package:green_2006/core/widgets/custom_gradient_button.dart';
import 'package:green_2006/features/auth/presentation/auth_forget_password_set_new_password_screen.dart';


class AuthForgotPasswordVerifyOtpScreen extends StatelessWidget {
  final String email;
  const AuthForgotPasswordVerifyOtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return _OtpContent(email: email);
  }
}

class _OtpContent extends StatefulWidget {
  final String email;
  const _OtpContent({required this.email});

  @override
  State<_OtpContent> createState() => _OtpContentState();
}

class _OtpContentState extends State<_OtpContent> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    // In a real app, you might want to auto-focus or show keyboard.
    // We'll show the custom keypad by default or when tapped.
    _isKeyboardVisible = true; 
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppSizes.hPadding.w, right: AppSizes.hPadding.w, top: AppSizes.s8.h,
        bottom: MediaQuery.of(context).padding.bottom + 8.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radius)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDragHandle(),
          _buildHeader(context),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: _isKeyboardVisible ? AppSizes.s8.h : AppSizes.s24.h),
                  _buildImage(),
                  SizedBox(height: AppSizes.s24.h),
                  _buildTitleSection(),
                  SizedBox(height: AppSizes.s32.h),
                  _buildPinput(),
                  SizedBox(height: AppSizes.s24.h),
                  _buildResendRow(),
                  SizedBox(height: AppSizes.s32.h),
                  _buildSubmitButton(),
                  SizedBox(height: AppSizes.s16.h),
                ],
              ),
            ),
          ),
          if (_isKeyboardVisible) _buildCustomKeypad(),
        ],
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

  Widget _buildImage() => Image.asset(
    AppAssets.emailImage,
    height: _isKeyboardVisible ? 60.h : 120.h,
    fit: BoxFit.contain,
  );

  Widget _buildTitleSection() => Column(
    children: [
      Text(AppStrings.verifyEmail, style: AppTextStyles.heading),
      SizedBox(height: AppSizes.s8.h),
      Text.rich(
        TextSpan(
          text: AppStrings.otpDesc,
          style: AppTextStyles.subHeading.copyWith(color: Colors.grey.shade600),
          children: [
            TextSpan(
              text: widget.email,
              style: AppTextStyles.subHeading.copyWith(color: const Color(0xFF6A1B9A), fontWeight: FontWeight.bold),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );

  Widget _buildPinput() {
    final defaultPinTheme = PinTheme(
      width: 65.w, height: 65.h,
      textStyle: TextStyle(fontSize: 24.sp, color: Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius / 2),
        border: Border.all(color: Colors.grey.shade200),
      ),
    );

    return Pinput(
      length: 4,
      controller: _pinController,
      focusNode: _focusNode,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: const Color(0xFF6A1B9A)),
        ),
      ),
      separatorBuilder: (index) => SizedBox(width: AppSizes.s10.w),
      showCursor: true,
      readOnly: true, // Use custom keypad
      onTap: () {
        setState(() => _isKeyboardVisible = true);
      },
    );
  }

  Widget _buildResendRow() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(AppStrings.didntReceiveCode, style: AppTextStyles.smallText),
      GestureDetector(
        onTap: () {},
        child: Text(AppStrings.resendCode, style: AppTextStyles.linkText.copyWith(fontWeight: FontWeight.bold)),
      ),
    ],
  );

  Widget _buildSubmitButton() => CustomGradientButton(
    text: AppStrings.sendCode,
    onPressed: () {
      if (_pinController.text.length == 4) {
        Navigator.pop(context);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radius)),
          ),
          builder: (context) => const AuthForgetPasswordSetNewPasswordScreen(),
        );
      }
    },
  );


  Widget _buildCustomKeypad() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: -AppSizes.hPadding.w),
      color: const Color(0xFFF3E5F5), // Light purple background
      padding: EdgeInsets.fromLTRB(8.w, 12.h, 8.w, 8.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildKeypadRow(["1", "2", "3"]),
          _buildKeypadRow(["4", "5", "6"]),
          _buildKeypadRow(["7", "8", "9"]),
          _buildKeypadRow(["+*#", "0", "DEL"]),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<String> keys) => Row(
    children: keys.map((key) => Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: () => _handleKeyTap(key),
          child: Container(
            height: 52.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, offset: const Offset(0, 1)),
              ],
            ),
            alignment: Alignment.center,
            child: _buildKeyContent(key),
          ),
        ),
      ),
    )).toList(),
  );

  Widget _buildKeyContent(String key) {
    if (key == "DEL") return const Icon(Icons.backspace_outlined, size: 22);
    if (key == "1") return _buildKeyWithSubtext("1", "");
    if (key == "2") return _buildKeyWithSubtext("2", "ABC");
    if (key == "3") return _buildKeyWithSubtext("3", "DEF");
    if (key == "4") return _buildKeyWithSubtext("4", "GHI");
    if (key == "5") return _buildKeyWithSubtext("5", "JKL");
    if (key == "6") return _buildKeyWithSubtext("6", "MNO");
    if (key == "7") return _buildKeyWithSubtext("7", "PQRS");
    if (key == "8") return _buildKeyWithSubtext("8", "TUV");
    if (key == "9") return _buildKeyWithSubtext("9", "WXYZ");
    
    return Text(key, style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.normal));
  }

  Widget _buildKeyWithSubtext(String key, String subtext) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(key, style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.normal, height: 1)),
      if (subtext.isNotEmpty)
        Text(subtext, style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.grey.shade600)),
    ],
  );

  void _handleKeyTap(String key) {
    if (key == "DEL") {
      if (_pinController.text.isNotEmpty) {
        _pinController.text = _pinController.text.substring(0, _pinController.text.length - 1);
      }
    } else if (int.tryParse(key) != null) {
      if (_pinController.text.length < 4) {
        _pinController.text += key;
      }
    }
  }
}
