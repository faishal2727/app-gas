import 'package:flutter/cupertino.dart';
import 'package:gas_ku/app/data/preference/preference_manager.dart';
import 'package:get/get.dart';
import '../../../data/api/api_service.dart';

class LoginController extends GetxController {
  final PreferenceManager _preferenceManager;
  final formKey = GlobalKey<FormState>();
  var obscureText = true.obs;
  static RxBool isLoading = false.obs;
  RxBool visibility = true.obs;
  RxBool isLoadingLogin = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService _apiService = ApiService();
  final RxString token = RxString('');

  LoginController(this._preferenceManager);

  @override
  void onInit() {
    super.onInit();
  }

  void toglePasswordVisibility() {
    obscureText.toggle();
  }

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final newToken = await _apiService.login(email, password);
      token.value = newToken?.toString() ?? '';
      await _preferenceManager.saveToken(newToken?.toString() ?? '');
      print("TOKEN ${newToken}");
      Get.offNamed('/home');
    } catch (e) {
      print(e);
      final errorMessage = e.toString();
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
