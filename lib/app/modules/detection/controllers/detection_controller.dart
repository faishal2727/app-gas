import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_ku/app/data/model/inventory.dart';
import 'package:get/get.dart';
import '../../../data/api/api_service.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/colors.dart';
import '../../history/bindings/history_binding.dart';

class DetectionController extends GetxController {
  final ApiService _apiService = ApiService();
  final formKey1 = GlobalKey<FormState>();
  RxBool visibility = true.obs;
  RxBool isLoadingLogin = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> inventory(
      String gasIjo, String brightGas, String blueGas) async {
    try {
      final addInventory = await _apiService.inventory(gasIjo, brightGas, blueGas);
      print("TOKEN $addInventory");
      Get.offNamed('/history');
    } catch (e) {
      print(e);
      final errorMessage = e.toString();
      Get.snackbar(
        'Error',
        'Error: $errorMessage',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  void initDetection() {
    // Memuat model
    loadModel();

    // Menginisialisasi pengolahan data
    initializeDataProcessing();

    // Memulai deteksi objek
    startObjectDetection();
  }

  void loadModel() {
    // Implementasi untuk memuat model
    // Anda dapat menggunakan paket seperti 'tflite_flutter' untuk memuat model TFLite
  }

  void initializeDataProcessing() {
    // Implementasi untuk menginisialisasi pengolahan data
    // Misalnya, memuat label atau mengatur konfigurasi deteksi objek
  }

  void startObjectDetection() {
    // Implementasi untuk memulai deteksi objek
    // Misalnya, memulai aliran gambar dari kamera dan meneruskan gambar ke model
    // untuk mendeteksi objek secara real-time
  }

  // void addData(String gasIjo, String brightGas, String blueGas) {
  //   isLoadingLogin.value = true;
  //   Timer(const Duration(seconds: 3), () {
  //     authService
  //         .addData(AddRequest(
  //             brightGas: brightGas, blueGas: blueGas, gasIjo: gasIjo))
  //         .then((value) {
  //       print(" coba ${value.message}");
  //       Get.showSnackbar(GetSnackBar(
  //           message: "coba2 ${value.message}",
  //           title: "Success",
  //           padding: const EdgeInsets.all(16),
  //           margin: const EdgeInsets.all(16 / 2),
  //           duration: const Duration(milliseconds: 2000)));
  //       HistoryBinding().dependencies();
  //       Get.offAllNamed(Routes.HISTORY);
  //     }).catchError((value) {
  //       Get.defaultDialog(
  //           title: "Ada Yang Salah Nih...",
  //           middleText: "${value.message}",
  //           backgroundColor: secondaryColor,
  //           titleStyle: TextStyle(color: Colors.white),
  //           middleTextStyle: TextStyle(color: Colors.white),
  //           radius: 30);
  //     });
  //     isLoadingLogin(false);
  //   });
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
