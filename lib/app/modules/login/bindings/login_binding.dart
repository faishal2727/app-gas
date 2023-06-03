import 'package:get/get.dart';

import '../../../data/api/api_service.dart';
import '../../../data/preference/preference_manager.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.lazyPut<LoginController>(
      () => LoginController(Get.find<PreferenceManager>()),
    );
  }
}
