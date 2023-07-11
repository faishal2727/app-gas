import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api/api_service.dart';

class ChangePasswordController extends GetxController {
   final ApiService _apiService = ApiService();
  final TextEditingController emailController = TextEditingController();

  Future<void> changePassword() async {
    try {
      final email = emailController.text;
      await _apiService.sendEmail(email);
      Get.snackbar('Sukses', 'Email berhasil dikirim ke $email', backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }
}
