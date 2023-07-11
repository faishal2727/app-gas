import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/api/api_service.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var obscureText = true.obs;
  var obscureText2 = true.obs;
  RxBool visibility = true.obs;
  RxBool visibilitys = true.obs;
  RxBool isLoadingSignUp = false.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> register() async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final rePassword = rePasswordController.text;

    if (password != rePassword) {
      Get.snackbar(
        'Error',
        "Brehasil)",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    try {
      isLoadingSignUp.value = true;
      await _apiService.register(name, email, password, rePassword);
      Get.offNamed('/login');
      Get.snackbar(
        'Berhasil',
        "Berhasil",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print(e);
      final errorMessage = e.toString();
      Get.snackbar(
        'Toast',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingSignUp.value = false;
    }
  }

  void toglePasswordVisibility() {
    obscureText.toggle();
  }

  void toglePasswordVisibility2() {
    obscureText2.toggle();
  }
}
