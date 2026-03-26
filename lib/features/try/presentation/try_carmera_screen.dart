import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_2006/features/try/presentation/image_details_screen.dart';

class TryCameraScreen extends StatefulWidget {
  const TryCameraScreen({super.key});

  @override
  State<TryCameraScreen> createState() => _TryCameraScreenState();
}

class _TryCameraScreenState extends State<TryCameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  int _selectedCameraIndex = 0;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras![_selectedCameraIndex],
        ResolutionPreset.high,
        enableAudio: false,
      );
      try {
        await _controller!.initialize();
      } catch (e) {
        debugPrint("Camera initialization error: $e");
      }
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _toggleCamera() async {
    if (_cameras == null || _cameras!.length < 2) return;
    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras!.length;
    await _controller?.dispose();
    _initCamera();
  }

  Future<void> _toggleFlash() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    _isFlashOn = !_isFlashOn;
    await _controller!.setFlashMode(
      _isFlashOn ? FlashMode.torch : FlashMode.off,
    );
    setState(() {});
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    if (_controller!.value.isTakingPicture) return;

    try {
      final XFile file = await _controller!.takePicture();
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDetailsScreen(file: File(file.path)),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error taking picture: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Preview
          _buildCameraPreview(),
          _buildTopControls(),
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }
    return SizedBox.expand(
      child: CameraPreview(_controller!),
    );
  }

  Widget _buildTopControls() => Positioned(
    top: 50.h, left: 20.w, right: 20.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
            child: const Icon(Icons.close, color: Colors.white, size: 20),
          ),
        ),
        IconButton(
          onPressed: _toggleFlash,
          icon: Icon(
            _isFlashOn ? Icons.flash_on : Icons.flash_off,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
    ),
  );

  Widget _buildBottomControls() => Positioned(
    bottom: 50.h, left: 32.w, right: 32.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 48), // Spacer
        _buildCaptureButton(),
        IconButton(
          onPressed: _toggleCamera,
          icon: const Icon(Icons.refresh, color: Colors.white, size: 36),
        ),
      ],
    ),
  );

  Widget _buildCaptureButton() => GestureDetector(
    onTap: _takePicture,
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 4), shape: BoxShape.circle),
      child: Container(
        width: 65.r, height: 65.r,
        decoration: const BoxDecoration(
          color: Color(0xFF6A1B9A),
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Color(0xFF8E24AA), Color(0xFF6A1B9A)],
          ),
        ),
      ),
    ),
  );
}
