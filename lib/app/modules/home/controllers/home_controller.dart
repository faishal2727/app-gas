
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import '../../../data/api/api_service.dart';
import '../../../data/model/gas.dart';
import '../../../data/model/gas_model.dart';

class HomeController extends GetxController {
  Rx<bool> shimmer = false.obs;
  var connectionStatus = 0.obs;
  String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  RxList<Gas> gas = <Gas>[].obs;
  final ApiService _apiService = ApiService();




  @override
  void onInit() {
    // showShimmer();
    // getAllGas();
    getDate();
    getListGas();
    super.onInit();
  }

  Future getDate() async {
 
  }


  Future<void> getListGas() async {
    try {
      final gasList = await _apiService.getListGas();
      gas.value = gasList;
    } catch (e) {
      print('Error getting list inventory: $e');
    }
  }
  // Future showShimmer() async {
  //   shimmer(true);
  // await Future.delayed(const Duration(seconds: 4), () {});
  // shimmer(false);
  // print("$shimmer $connectionStatus");
  // shimmer.refresh();
  // }
}
