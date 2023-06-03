import 'dart:convert';

import 'package:gas_ku/app/data/preference/preference_manager.dart';
import 'package:get/get.dart';

import '../../../data/api/api_service.dart';
import '../../../data/model/user.dart';

class ProfileController extends GetxController {
   final PreferenceManager _preferenceManager;
  Rx<User> currentUser = User(name: '', email: '').obs;

  final ApiService _apiService = ApiService();
  bool isLoading = false;
  String? errorMessage;

  ProfileController(this._preferenceManager);

  String get token => _preferenceManager.getToken() ?? '';

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUser();
  }

  void fetchCurrentUser() async {
    final token = _preferenceManager.getToken();
    if (token != null && token.isNotEmpty) {
      final tokenValue = jsonDecode(token)['token'] as String? ?? '';

      if (tokenValue != null) {
        print(
            "Token: ${tokenValue.runtimeType}"); // Cetak token sebelum mengirim permintaan HTTP
        try {
          final user = await _apiService.getCurrentUser(tokenValue);
          currentUser.value = user;
          print(
              'Current User: $user'); // Cetak pengguna setelah mendapatkan respons dari server
        } catch (e) {
          print("Error C: $e");
        }
      } else {
        print('Token value is null');
      }
    } else {
      print('Token is null or empty');
    }
  }

  Future<void> logout() async {
    await _preferenceManager.removeToken();
    Get.offNamed('/login');
  }
}
