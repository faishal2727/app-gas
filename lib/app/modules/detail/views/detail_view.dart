import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:open_whatsapp/open_whatsapp.dart';
import '../../../component/arrow_back.dart';
import '../../../theme/colors.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  final uye = Get.put(HomeController());
  final Uri _url = Uri.parse('https://flutter.dev');

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidht = MediaQuery.of(context).size.width;
    final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Color.fromARGB(231, 0, 0, 0),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                backgroundColor: bgColor,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                expandedHeight: bodyHeight * 0.3,
                flexibleSpace: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: Text('gambar'),
                      child: Image.network(controller.image.image,
                          fit: BoxFit.cover),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Color.fromARGB(248, 0, 0, 0)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          controller.gasName.gasName,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: bodyHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: bgColor,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.gasName.gasName,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text('Ukuran : '),
                            Text(controller.size.size)
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text('Persediaan Wajib : '),
                            Text(controller.currentStock.currentStock)
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text('Min. Persediaan: '),
                            Text(controller.minStock.minStock)
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text('No. Distributor: '),
                            Text(controller.noHpDist.noHpDist)
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   FloatingActionButton.extended(
      //     label: const Text('Approve'),
      //     icon: const Icon(Icons.thumb_up),
      //     backgroundColor: Colors.pink,
      //     onPressed: () {},
      //   ),
      // ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        backgroundColor: primaryColor,
        childrenOffset: Offset(5, 10),
        child: Icon(Icons.phone_in_talk_rounded),
        children: [
          FloatingActionButton.small(
            tooltip: 'SMS',
            heroTag: null,
            backgroundColor: primaryColor,
            child: const Icon(Icons.message),
            onPressed: () => controller.aunchUrl(),
          ),
          FloatingActionButton.small(
            heroTag: null,
            tooltip: 'Telepon',
            backgroundColor: primaryColor,
            child: const Icon(Icons.phone_enabled_outlined),
            onPressed: () => controller.launchPhone(),
          ),
          FloatingActionButton.small(
            tooltip: 'Whatsap',
            // heroTag: Text('Whatsap'),
            backgroundColor: primaryColor,
            child: const Icon(Icons.wechat_sharp),
            onPressed: () {FlutterOpenWhatsapp.sendSingleMessage("918179015345", "Hello"); },
          ),
        ],
      ),
    );
  }
}
