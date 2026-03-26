import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import 'package:green_2006/core/constens/app_sizes.dart';
import 'package:green_2006/core/constens/app_strings.dart';
import 'package:green_2006/core/constens/app_text_styles.dart';
import 'package:green_2006/core/widgets/custom_gradient_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_2006/features/try/presentation/bloc/try_on_bloc.dart';
import 'package:green_2006/features/try/presentation/bloc/try_on_event.dart';
import 'package:green_2006/features/try/presentation/try_loading_screen.dart';

class ImageDetailsScreen extends StatelessWidget {
  final AssetEntity? asset;
  final File? file;

  const ImageDetailsScreen({super.key, this.asset, this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6A1B9A)),
        ),
        title: Text(
          AppStrings.imageAndDetails,
          style: AppTextStyles.heading.copyWith(color: const Color(0xFF6A1B9A)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.hPadding.w),
        child: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(AppSizes.radius.r),
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: _buildImage(),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(child: _buildRetakeButton(context)),
                  SizedBox(width: 16.w),
                  Expanded(child: _buildUsePhotoButton(context)),
                ],
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (asset != null) {
      return AssetEntityImage(
        asset!,
        isOriginal: true,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    } else if (file != null) {
      return Image.file(file!, fit: BoxFit.cover, width: double.infinity);
    }
    return const SizedBox();
  }

  Widget _buildRetakeButton(BuildContext context) => OutlinedButton(
    onPressed: () => Navigator.pop(context),
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      side: const BorderSide(color: Color(0xFF6A1B9A)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
    ),
    child: Text(
      AppStrings.retake,
      style: TextStyle(
        color: const Color(0xFF6A1B9A),
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  Widget _buildUsePhotoButton(BuildContext context) => CustomGradientButton(
    text: AppStrings.useThisPhoto,
    onPressed: () => _onUsePhoto(context),
  );

  void _onUsePhoto(BuildContext context) async {
    File? fileToProcess = file;
    if (asset != null) {
      fileToProcess = await asset!.file;
    }
    if (fileToProcess != null && context.mounted) {
      context.read<TryOnBloc>().add(StartTryOnProcessingEvent(fileToProcess));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TryLoadingScreen()),
      );
    }
  }
}
