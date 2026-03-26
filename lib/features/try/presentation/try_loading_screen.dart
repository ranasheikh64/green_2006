import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_2006/core/constens/app_strings.dart';
import 'package:green_2006/core/constens/app_text_styles.dart';
import 'package:green_2006/features/try/presentation/bloc/try_on_bloc.dart';
import 'package:green_2006/features/try/presentation/bloc/try_on_state.dart';

class TryLoadingScreen extends StatelessWidget {
  const TryLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TryOnBloc, TryOnState>(
      listener: (context, state) {
        if (state.status == TryOnStatus.success) {
          // Navigate to result screen (future task)
          Navigator.pop(context);
        } else if (state.status == TryOnStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? "Processing failed")),
          );
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F5F9),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40),
                    Text(
                      AppStrings.hairify,
                      style: AppTextStyles.heading.copyWith(
                        color: const Color(0xFF6A1B9A),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              BlocBuilder<TryOnBloc, TryOnState>(
                builder: (context, state) {
                  return _buildLoadingContent(state.loadingStage);
                },
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingContent(int stage) {
    switch (stage) {
      case 0:
        return Column(
          children: [
            _buildAnimatedDots(),
            SizedBox(height: 32.h),
            Text(AppStrings.analyzingFace, style: AppTextStyles.heading.copyWith(fontSize: 24.sp)),
            SizedBox(height: 12.h),
            Text(AppStrings.applyingHairstyle, style: AppTextStyles.smallText.copyWith(color: Colors.grey.shade600)),
          ],
        );
      case 1:
        return _buildStageContent(Icons.face, AppStrings.creatingStructure);
      case 2:
        return _buildStageContent(Icons.palette, AppStrings.creatingSkinTones);
      case 3:
        return _buildStageContent(Icons.auto_awesome, AppStrings.creatingMagic);
      default:
        return const SizedBox();
    }
  }

  Widget _buildAnimatedDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(const Color(0xFF6A1B9A)),
        SizedBox(width: 12.w),
        _buildDot(const Color(0xFF6A1B9A).withOpacity(0.5)),
        SizedBox(width: 12.w),
        _buildDot(const Color(0xFF6A1B9A).withOpacity(0.2)),
      ],
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 28.r,
      height: 28.r,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildStageContent(IconData icon, String text) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(24.r),
          decoration: const BoxDecoration(color: Color(0xFFF3E5F5), shape: BoxShape.circle),
          child: Icon(icon, color: const Color(0xFF6A1B9A), size: 54.sp),
        ),
        SizedBox(height: 48.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppTextStyles.heading.copyWith(fontSize: 18.sp, color: Colors.grey.shade700),
          ),
        ),
      ],
    );
  }
}

