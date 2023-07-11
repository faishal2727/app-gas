import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    // Simulasikan penundaan 3 detik untuk tampilan splash screen
    Future.delayed(Duration(seconds: 3), () {
        Get.offNamed('/login');
      
    });
  }
}
