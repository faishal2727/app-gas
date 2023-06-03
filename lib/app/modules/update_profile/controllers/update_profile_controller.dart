import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/api/api_service.dart';
import '../../../data/preference/preference_manager.dart';

class UpdateProfileController extends GetxController {
  final PreferenceManager _preferenceManager;
  final ApiService _apiService = ApiService();
  bool isLoading = false;
  String? errorMessage;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String get token => _preferenceManager.getToken() ?? '';

  UpdateProfileController(this._preferenceManager);

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> updateUser() async {
    final newName = nameController.text;
    final newEmail = emailController.text;
    final token = _preferenceManager.getToken();

    if (token != null) {
      try {
        final tokenValue = jsonDecode(token)['token'] as String;
        final message =
            await _apiService.updateUser(tokenValue, newName, newEmail);
        print('Pengguna berhasil diperbarui: $message');
        nameController.text = newName;
        emailController.text = newEmail;
        Get.snackbar(
          'Sukses',
          "Sukses Update User",
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offNamed('/profile');
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
        print('Error updating user: $e');
      }
    }
  }
}
