import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gas_ku/app/theme/colors.dart';
import 'package:get/get.dart';
import '../controllers/detection_controller.dart';
import 'camera_screen.dart';

late List<CameraDescription> cameras;

class DetectionView extends GetView<DetectionController> {
  const DetectionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: CameraScreen(cameras),
    );
  }
}
