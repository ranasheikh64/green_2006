import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:green_2006/core/constens/app_assets.dart';
import 'package:green_2006/core/constens/app_sizes.dart';
import 'package:green_2006/core/constens/app_strings.dart';
import 'package:green_2006/core/constens/app_text_styles.dart';
import 'package:green_2006/core/widgets/custom_gradient_background.dart';
import 'package:green_2006/features/try/presentation/image_details_screen.dart';
import 'package:green_2006/features/try/presentation/try_carmera_screen.dart';


class TryHomeScreen extends StatelessWidget {
  const TryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TryHomeContent();
  }
}

class _TryHomeContent extends StatefulWidget {
  const _TryHomeContent();

  @override
  State<_TryHomeContent> createState() => _TryHomeContentState();
}

class _TryHomeContentState extends State<_TryHomeContent> {
  List<AssetEntity> _assets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAssets();
  }

  Future<void> _fetchAssets() async {
    try {
      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      if (ps.isAuth || ps.hasAccess) {
        final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
          type: RequestType.image,
        );
        if (paths.isNotEmpty) {
          final List<AssetEntity> entities = await paths[0].getAssetListPaged(
            page: 0,
            size: 24,
          );
          if (mounted) {
            setState(() {
              _assets = entities;
              _isLoading = false;
            });
          }
        } else {
          if (mounted) setState(() => _isLoading = false);
        }
      } else {
        if (mounted) setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radius)),
      ),
      child: CustomGradientBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.hPadding.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDragHandle(),
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSizes.s24.h),
                      Text(AppStrings.captureImage, style: AppTextStyles.heading.copyWith(fontSize: 22.sp)),
                      SizedBox(height: AppSizes.s16.h),
                      _buildCaptureButton(context),
                      SizedBox(height: AppSizes.s32.h),
                      Text(AppStrings.selectFromGallery, style: AppTextStyles.heading.copyWith(fontSize: 22.sp)),
                      SizedBox(height: AppSizes.s16.h),
                      _buildGalleryGrid(),
                      SizedBox(height: AppSizes.s24.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDragHandle() => Center(
    child: Container(
      width: 48.w, height: 4.h,
      margin: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
    ),
  );

  Widget _buildHeader(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(AppStrings.selectMethod, style: AppTextStyles.heading.copyWith(color: const Color(0xFF6A1B9A))),
      IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: Colors.grey.shade400)),
    ],
  );

  Widget _buildCaptureButton(BuildContext context) => InkWell(
    onTap: () async {
      PermissionStatus status = await Permission.camera.request();
      if (status.isGranted) {
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TryCameraScreen()),
          );
        }
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    },
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(AppSizes.radius.r),
        border: Border.all(color: const Color(0xFF6A1B9A).withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Image.asset(AppAssets.cameraImage, height: 64.h),
          SizedBox(height: 12.h),
          Text(AppStrings.captureImage, style: AppTextStyles.heading.copyWith(fontSize: 18.sp, color: const Color(0xFF6A1B9A))),
        ],
      ),
    ),
  );

  Widget _buildGalleryGrid() {
    if (_isLoading) {
      return SizedBox(
        height: 200.h,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_assets.isEmpty) {
      return SizedBox(
        height: 200.h,
        child: Center(child: Text("No images found", style: AppTextStyles.smallText)),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1,
      ),
      itemCount: _assets.length,
      itemBuilder: (context, index) {
        final asset = _assets[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageDetailsScreen(asset: asset),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: AssetEntityImage(
              asset,
              isOriginal: false,
              thumbnailSize: const ThumbnailSize.square(200),
              fit: BoxFit.cover,
            ),
          ),
        );
      },

    );
  }
}
