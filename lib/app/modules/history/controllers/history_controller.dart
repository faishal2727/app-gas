import 'package:gas_ku/app/data/model/inventory.dart';
import 'package:get/get.dart';
import '../../../data/api/api_service.dart';

class HistoryController extends GetxController {
  RxList<Inventory> history = <Inventory>[].obs;
  final ApiService _apiService = ApiService();
  final isLoading = false.obs;

  @override
  void onInit() {
    print('Controller JAlan');
    getListInventory();
    super.onInit();
  }

  Future<void> getListInventory() async {
    try {
      isLoading.value = true;
      final inventoryList = await _apiService.getListInventory();
      history.value = inventoryList;
      print('Inventory data loaded: ${history.length}');
    } catch (e) {
      print('Error getting list inventory: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
