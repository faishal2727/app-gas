import 'package:gas_ku/app/data/model/inventory.dart';
import 'package:get/get.dart';
import '../../../data/api/api_service.dart';

class HistoryController extends GetxController {
  RxList<Inventory> history = <Inventory>[].obs;
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    getListInventory();
    super.onInit();
  }

  Future<void> getListInventory() async {
    try {
      final inventoryList = await _apiService.getListInventory();
      history.value = inventoryList;
    } catch (e) {
      print('Error getting list inventory: $e');
    }
  }
}
