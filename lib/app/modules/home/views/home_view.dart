import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../component/card_deteksi.dart';
import '../../../component/card_history.dart';
import '../../../component/card_main.dart';
import '../../../component/card_profile.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      final mediaQueryHeight = MediaQuery.of(context).size.height;
      final mediaQueryWidth = MediaQuery.of(context).size.width;
      final bodyHeight = mediaQueryHeight - MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: secondaryColor,
              height: bodyHeight * .1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.cdate.toString(),
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hai,',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              ' Admin 1',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.PROFILE),
                    child: Card_Profile(),
                  ),
                ],
              ),
            ),
            Container(
              width: Get.width,
              height: bodyHeight * .9,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height * .1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  color: bgColor),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(
                        'Menu Utama',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Card_History(),
                        Card_Deteksi(),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text('Daftar Gas',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Obx(() {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.gas.length,
                        itemBuilder: (context, index) {
                          // final GasDetail gas = gasList[index];
                          return Card_Gas(gas: controller.gas[index]);
                          // InkWell(
                          //     onTap: () {
                          //       Get.toNamed(Routes.DETAIL, arguments: [
                          //         controller.gas[index].gasName,
                          //         controller.gas[index].image,
                          //         controller.gas[index].size,
                          //         controller.gas[index].currentStock,
                          //         controller.gas[index].mustStock,
                          //         controller.gas[index].minStock,
                          //         controller.gas[index].noHpDist
                          //       ]);
                          //       print("uny ${controller.gas[index].size}");
                          //       print("PALAK ${[
                          //         controller.gas[index].size,
                          //         controller.gas[index].gasName
                          //       ]}");
                          //     },
                          //     child: Card_Gas(gas: controller.gas[index]));
                        },
                      );
                    }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
