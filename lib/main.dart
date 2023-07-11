import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/data/preference/preference_manager.dart';
import 'app/modules/detection/views/detection_view.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.camera.request();
  await Permission.microphone.request();

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  PreferenceManager preferenceManager = PreferenceManager(sharedPreferences);
  Get.put<PreferenceManager>(
      preferenceManager); // Tambahkan argumen SharedPreferences

  String? token = preferenceManager.getToken();
  String initialRoute = token != null ? '/home' : AppPages.INITIAL;
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: initialRoute, // Perubahan pada initialRoute
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
