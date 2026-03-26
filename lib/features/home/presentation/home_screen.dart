import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_2006/core/constens/app_assets.dart';
import 'package:green_2006/core/constens/app_sizes.dart';
import 'package:green_2006/core/constens/app_strings.dart';
import 'package:green_2006/core/constens/app_text_styles.dart';
import 'package:green_2006/core/widgets/custom_gradient_background.dart';
import 'package:green_2006/features/try/presentation/try_home_screen.dart';
import 'bloc/home_bloc.dart';


import 'bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.hPadding.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSizes.s24.h),
                _buildHeader(),
                SizedBox(height: AppSizes.s32.h),
                _buildTryNewHairstyleCard(context),

                SizedBox(height: AppSizes.s32.h),
                _buildRecentlyCreatedSection(context),
                SizedBox(height: AppSizes.s24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: AppStrings.hello,
                style: AppTextStyles.heading.copyWith(fontSize: 24.sp),
                children: [
                  TextSpan(text: "Nusrat", style: AppTextStyles.heading.copyWith(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text(AppStrings.readyLook, style: AppTextStyles.subHeading.copyWith(color: const Color(0xFF6A1B9A))),
          ],
        ),
        CircleAvatar(
          radius: 28.r,
          backgroundImage: const AssetImage(AppAssets.authHome), // Placeholder
        ),
      ],
    );
  }

  Widget _buildTryNewHairstyleCard(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(AppSizes.s16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.tryNewHairstyle, style: AppTextStyles.heading.copyWith(fontSize: 20.sp)),
          SizedBox(height: AppSizes.s8.h),
          Text(AppStrings.tryNewHairstyleDesc, style: AppTextStyles.smallText.copyWith(color: Colors.grey.shade600)),
          SizedBox(height: AppSizes.s24.h),
          Row(
            children: [
              Expanded(child: _buildActionButton(context, AppStrings.useCamera, AppAssets.cameraImage)),
              SizedBox(width: AppSizes.s16.w),
              Expanded(child: _buildActionButton(context, AppStrings.uploadPhoto, AppAssets.galleryImage)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String label, String iconPath) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const TryHomeScreen(),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF3E5F5),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Image.asset(iconPath, height: 60.h),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFF6A1B9A),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.r), bottomRight: Radius.circular(16.r)),
              ),
              alignment: Alignment.center,
              child: Text(label, style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildRecentlyCreatedSection(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.recentlyCreatedLooks, style: AppTextStyles.heading.copyWith(fontSize: 20.sp)),
            TextButton(onPressed: () {}, child: Text(AppStrings.viewAll, style: AppTextStyles.linkText)),
          ],
        ),
        SizedBox(height: AppSizes.s16.h),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.looks.isEmpty) {
              return Center(child: Text("No looks found", style: AppTextStyles.smallText));
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSizes.s16.w,
                mainAxisSpacing: AppSizes.s16.h,
                childAspectRatio: 0.8,
              ),
              itemCount: state.looks.length,
              itemBuilder: (context, index) {
                final look = state.looks[index];
                return _buildLookCard(look);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildLookCard(dynamic look) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius.r),
        image: DecorationImage(image: AssetImage(look.imageUrl), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12.h, right: 12.w,
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(8.r)),
              child: Icon(look.isBookmarked ? Icons.bookmark : Icons.bookmark_border, size: 20.sp, color: const Color(0xFF6A1B9A)),
            ),
          ),
        ],
      ),
    );
  }
}
