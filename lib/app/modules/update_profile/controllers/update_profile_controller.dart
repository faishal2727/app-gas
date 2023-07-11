import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/api/api_service.dart';
import '../../../data/model/user.dart';
import '../../../data/preference/preference_manager.dart';
import '../../profile/controllers/profile_controller.dart';

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
    // Mengisi nilai default pada nameController dan emailController
    final currentUser = Get.find<ProfileController>().currentUser.value;
    nameController.text = currentUser.name;
    emailController.text = currentUser.email;
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
        Get.find<ProfileController>().currentUser.value = User(name: newName, email: newEmail);
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
