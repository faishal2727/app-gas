import 'package:gas_ku/app/modules/history/controllers/history_controller.dart';
import 'package:gas_ku/app/modules/visualisasi/controllers/visualisasi_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/api/api_service.dart';
import '../../../data/model/gas.dart';


class HomeController extends GetxController {
  Rx<bool> shimmer = false.obs;
  var connectionStatus = 0.obs;
  String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  RxList<Gas> gas = <Gas>[].obs;
  final ApiService _apiService = ApiService();
  final isLoading = false.obs;
  final uye = Get.put(HistoryController);

  @override
  void onInit() {
    // showShimmer();
    // getAllGas();
    getListGas();
    Get.put(HistoryController);
    super.onInit();
  }

  Future<void> getListGas() async {
    try {
      isLoading.value = true;
      final gasList = await _apiService.getListGas();
      gas.value = gasList;
    } catch (e) {
      print('Error getting list inventory: $e');
    } finally {
      isLoading.value = false;
    }
  }

}
