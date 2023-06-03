import 'package:get/get.dart';

import '../controllers/visualisasi_controller.dart';

class VisualisasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisualisasiController>(
      () => VisualisasiController(),
    );
  }
}
