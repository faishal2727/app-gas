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
}
