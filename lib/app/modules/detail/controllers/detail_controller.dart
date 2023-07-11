import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailController extends GetxController {
  final count = 0.obs;
  final size = Get.arguments;
  final gasName = Get.arguments;
  final image = Get.arguments;
  final currentStock = Get.arguments;
  final mustStock = Get.arguments;
  final minStock = Get.arguments;
  final noHpDist = Get.arguments;
  final Uri _url = Uri.parse('https://flutter.dev');
  Uri sms = Uri.parse('sms:101022?body=your+text+here');
  Uri phoneno = Uri.parse('tel:+97798345348734');

  @override
  void onInit() {
    print("size is $size");
    print("namanya is ${gasName}");
    super.onInit();
  }

  Future<void> aunchUrl() async {
    if (!await launchUrl(sms)) {
      throw Exception('Could not launch $sms');
    }
  }

   Future<void> launchPhone() async {
    if (!await launchUrl(phoneno)) {
      throw Exception('Could not launch $noHpDist');
    }
  }
}
